/**
 * 3D to 2D projection utilities for panel rendering
 */

// Camera configuration
const camera = {
  position: { x: 0, y: 0, z: 500 },
  focalLength: 300,
};

/**
 * Projects a 3D point to 2D screen coordinates
 */
export const project3DTo2D = (point3D, camera) => {
  const dx = point3D.x - camera.position.x;
  const dy = point3D.y - camera.position.y;
  const dz = point3D.z - camera.position.z;

  // Perspective projection
  const scale = camera.focalLength / (camera.focalLength + dz);

  return {
    x: dx * scale + 300, // Center on canvas
    y: dy * scale + 300,
    z: dz, // Keep z for depth sorting
  };
};

/**
 * Rotates a point around the Y axis (vertical axis)
 */
export const rotateY = (point, angle) => {
  const rad = (angle * Math.PI) / 180;
  const cos = Math.cos(rad);
  const sin = Math.sin(rad);

  return {
    x: point.x * cos + point.z * sin,
    y: point.y,
    z: -point.x * sin + point.z * cos,
  };
};

/**
 * Rotates a point around the Z axis (depth axis)
 */
export const rotateZ = (point, angle) => {
  const rad = (angle * Math.PI) / 180;
  const cos = Math.cos(rad);
  const sin = Math.sin(rad);

  return {
    x: point.x * cos - point.y * sin,
    y: point.x * sin + point.y * cos,
    z: point.z,
  };
};

/**
 * Calculates the 4 corners of a panel in 3D space
 */
export const getPanelCorners3D = (panel) => {
  const { x, y, z = 0, width, height, rotationY = 0, rotationZ = 0 } = panel;

  // Define corners in local space (centered at origin)
  const halfWidth = width / 2;
  const halfHeight = height / 2;

  let corners = [
    { x: -halfWidth, y: -halfHeight, z: 0 }, // Top-left
    { x: halfWidth, y: -halfHeight, z: 0 },  // Top-right
    { x: halfWidth, y: halfHeight, z: 0 },   // Bottom-right
    { x: -halfWidth, y: halfHeight, z: 0 },  // Bottom-left
  ];

  // Apply rotations
  corners = corners.map(corner => {
    let rotated = corner;
    if (rotationZ !== 0) rotated = rotateZ(rotated, rotationZ);
    if (rotationY !== 0) rotated = rotateY(rotated, rotationY);
    return rotated;
  });

  // Translate to world position
  corners = corners.map(corner => ({
    x: corner.x + x,
    y: corner.y + y,
    z: corner.z + z,
  }));

  return corners;
};

/**
 * Converts panel 3D corners to 2D projected polygon with optional view rotation
 */
export const projectPanel = (panel, viewRotationY = 0) => {
  let corners3D = getPanelCorners3D(panel);

  // Apply view rotation to rotate the entire scene
  if (viewRotationY !== 0) {
    corners3D = corners3D.map(corner => rotateY(corner, viewRotationY));
  }

  const corners2D = corners3D.map(corner => project3DTo2D(corner, camera));

  // Calculate average Z for depth sorting
  const avgZ = corners2D.reduce((sum, c) => sum + c.z, 0) / corners2D.length;

  return {
    corners: corners2D,
    avgZ: avgZ,
    panel: panel,
  };
};

/**
 * Checks if a panel is visible (facing the camera)
 */
export const isPanelVisible = (projectedPanel) => {
  const corners = projectedPanel.corners;

  // Calculate cross product to determine facing direction
  const v1 = {
    x: corners[1].x - corners[0].x,
    y: corners[1].y - corners[0].y,
  };
  const v2 = {
    x: corners[2].x - corners[0].x,
    y: corners[2].y - corners[0].y,
  };

  const cross = v1.x * v2.y - v1.y * v2.x;

  // If cross product is positive, panel is facing camera
  return cross > 0;
};

export default {
  project3DTo2D,
  rotateY,
  rotateZ,
  getPanelCorners3D,
  projectPanel,
  isPanelVisible,
  camera,
};
