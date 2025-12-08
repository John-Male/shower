/**
 * Rotate shower configuration around the Y-axis (vertical)
 * to bring a specific panel to the foreground
 */

import { rotateY } from './projection3D';

/**
 * Rotate entire shower configuration around Y-axis
 * @param {Array} panels - Original panel configuration
 * @param {number} rotationAngle - Angle in degrees to rotate (positive = counterclockwise)
 * @returns {Array} - Rotated panel configuration
 */
export const rotateShower = (panels, rotationAngle) => {
  return panels.map(panel => {
    // Rotate the panel's position
    const rotatedPos = rotateY({ x: panel.x, y: panel.y, z: panel.z }, rotationAngle);

    // Update the panel's own rotation (handle negative angles properly)
    let newRotationY = (panel.rotationY + rotationAngle) % 360;
    if (newRotationY < 0) newRotationY += 360;

    return {
      ...panel,
      x: rotatedPos.x,
      y: rotatedPos.y,
      z: rotatedPos.z,
      rotationY: newRotationY,
    };
  });
};

/**
 * Calculate rotation needed to bring a panel to foreground
 * Uses 95-degree over-rotation for better viewing angle
 * @param {Object} currentPanel - The panel to bring to foreground
 * @param {string} direction - 'left' or 'right'
 * @returns {number} - Rotation angle in degrees
 */
export const calculateRotationForPanel = (currentPanel, direction) => {
  if (!currentPanel) return 0;

  const baseRotation = -currentPanel.rotationY;

  // Add 95-degree over-rotation based on direction
  if (direction === 'left') {
    return baseRotation - 95;
  } else if (direction === 'right') {
    return baseRotation + 95;
  }

  return baseRotation;
};

/**
 * Get rotated shower configuration for current view
 * @param {Array} baseShower - Original shower configuration
 * @param {number} currentPanelId - Current focused panel
 * @param {Array} allPanels - Current panel array (to find panel)
 * @returns {Array} - Rotated shower configuration
 */
export const getRotatedShowerForPanel = (baseShower, currentPanelId, allPanels) => {
  const currentPanel = allPanels.find(p => p.id === currentPanelId);
  if (!currentPanel) return baseShower;

  // Determine rotation based on panel orientation
  // Goal: Rotate the panel to face forward (0°) plus over-rotation
  let rotationAngle = 0;

  if (currentPanel.rotationY === 0) {
    // Front-facing panel (1, 11) - no rotation needed
    rotationAngle = 0;
  } else if (currentPanel.rotationY === 90) {
    // Left wall (panel 3) at 90° - rotate RIGHT (clockwise) to bring it forward
    // User pressed RIGHT button, image should rotate right
    rotationAngle = 95;
  } else if (currentPanel.rotationY === 270) {
    // Right wall (panel 2) at 270° - rotate LEFT (counterclockwise) to bring it forward
    // User pressed LEFT button, image should rotate left
    rotationAngle = -95;
  } else if (currentPanel.rotationY === 180) {
    // Back wall - rotate 180
    rotationAngle = 180;
  }

  return rotateShower(baseShower, rotationAngle);
};
