// Panel type definitions for different shapes

export const PANEL_TYPES = {
  NORMAL: 'normal',
  LEFT_SINGLE_STEP: 'left_single_step',
  RIGHT_SINGLE_STEP: 'right_single_step',
  BOTH_SINGLE_STEP: 'both_single_step',
  LEFT_DOUBLE_STEP: 'left_double_step',
  RIGHT_DOUBLE_STEP: 'right_double_step',
};

export const PANEL_TYPE_LABELS = {
  [PANEL_TYPES.NORMAL]: 'Normal (Rectangle)',
  [PANEL_TYPES.LEFT_SINGLE_STEP]: 'Left Single Step',
  [PANEL_TYPES.RIGHT_SINGLE_STEP]: 'Right Single Step',
  [PANEL_TYPES.BOTH_SINGLE_STEP]: 'Both Single Step',
  [PANEL_TYPES.LEFT_DOUBLE_STEP]: 'Left Double Step',
  [PANEL_TYPES.RIGHT_DOUBLE_STEP]: 'Right Double Step',
};

/**
 * Create a default panel shape configuration based on type
 * Steps are cutouts at the BOTTOM (for panels that fit over stairs)
 */
export function createDefaultPanelShape(type, baseWidth = 50, baseHeight = 100) {
  const shape = {
    type,
    base_width: baseWidth,
    base_height: baseHeight,
  };

  switch (type) {
    case PANEL_TYPES.NORMAL:
      // No additional properties needed
      break;

    case PANEL_TYPES.LEFT_SINGLE_STEP:
      shape.left_base_width = baseWidth * 0.3; // 20% of base width
      shape.left_base_height = baseHeight * 0.3; // 15% of base height
      break;

    case PANEL_TYPES.RIGHT_SINGLE_STEP:
      shape.right_base_width = baseWidth * 0.3;
      shape.right_base_height = baseHeight * 0.3;
      break;

    case PANEL_TYPES.BOTH_SINGLE_STEP:
      shape.left_base_width = baseWidth * 0.3;
      shape.left_base_height = baseHeight * 0.3;
      shape.right_base_width = baseWidth * 0.3;
      shape.right_base_height = baseHeight * 0.3;
      break;

    case PANEL_TYPES.LEFT_DOUBLE_STEP:
      // First step (outer/lower)
      shape.left_base_width = baseWidth * 0.3;
      shape.left_base_height = baseHeight * 0.3;
      // Second step (middle) - total width/height from edge
      shape.left_base_width_2 = baseWidth * 0.6; // 0.3 + 0.3
      shape.left_base_height_2 = baseHeight * 0.6; // 0.3 + 0.3
      break;

    case PANEL_TYPES.RIGHT_DOUBLE_STEP:
      // First step (outer/lower)
      shape.right_base_width = baseWidth * 0.3;
      shape.right_base_height = baseHeight * 0.3;
      // Second step (middle) - total width/height from edge
      shape.right_base_width_2 = baseWidth * 0.6; // 0.3 + 0.3
      shape.right_base_height_2 = baseHeight * 0.6; // 0.3 + 0.3
      break;

    default:
      console.warn(`Unknown panel type: ${type}`);
  }

  return shape;
}

/**
 * Get the total width of a panel shape
 */
export function getPanelShapeWidth(shape) {
  if (!shape) return 0;
  return shape.base_width || 0;
}

/**
 * Get the total height of a panel shape
 */
export function getPanelShapeHeight(shape) {
  if (!shape) return 0;
  return shape.base_height || 0;
}

/**
 * Generate SVG path data for a panel shape
 * Returns an array of path segments that define the panel outline
 * Steps are cutouts at the BOTTOM (for panels that fit over stairs)
 */
export function generatePanelShapePath(shape) {
  if (!shape || shape.type === PANEL_TYPES.NORMAL) {
    // Simple rectangle
    const w = shape?.base_width || 50;
    const h = shape?.base_height || 100;
    return [
      { x: 0, y: 0 },
      { x: w, y: 0 },
      { x: w, y: h },
      { x: 0, y: h },
    ];
  }

  const points = [];
  const baseWidth = shape.base_width;
  const baseHeight = shape.base_height;

  // Start at top-left corner
  points.push({ x: 0, y: 0 });

  // Top edge
  points.push({ x: baseWidth, y: 0 });

  // Right edge - go down to where steps begin (if any)
  if (shape.right_base_width && shape.right_base_height) {
    if (shape.right_base_width_2 && shape.right_base_height_2) {
      // Double step - create two distinct steps
      const firstStepTop = baseHeight - shape.right_base_height_2;

      // Go down to where first step begins
      points.push({ x: baseWidth, y: firstStepTop });

      // Cut inward for first step
      points.push({ x: baseWidth - shape.right_base_width, y: firstStepTop });

      // Go down the height of one step
      const secondStepTop = baseHeight - (shape.right_base_height_2 - shape.right_base_height);
      points.push({ x: baseWidth - shape.right_base_width, y: secondStepTop });

      // Cut inward for second step
      points.push({ x: baseWidth - shape.right_base_width_2, y: secondStepTop });

      // Go down to bottom
      points.push({ x: baseWidth - shape.right_base_width_2, y: baseHeight });
    } else {
      // Single step
      const firstStepTop = baseHeight - shape.right_base_height;
      points.push({ x: baseWidth, y: firstStepTop });

      // Cut inward for first step
      points.push({ x: baseWidth - shape.right_base_width, y: firstStepTop });

      // Go straight down to bottom
      points.push({ x: baseWidth - shape.right_base_width, y: baseHeight });
    }
  } else {
    // No right steps, go straight down
    points.push({ x: baseWidth, y: baseHeight });
  }

  // Bottom edge - walk back across the bottom with left steps
  if (shape.left_base_width && shape.left_base_height) {
    if (shape.left_base_width_2 && shape.left_base_height_2) {
      // Double step - create two distinct steps
      const firstStepTop = baseHeight - shape.left_base_height_2;

      // At bottom, walk left to where second step starts
      points.push({ x: shape.left_base_width_2, y: baseHeight });

      // Go up for second step
      const secondStepTop = baseHeight - (shape.left_base_height_2 - shape.left_base_height);
      points.push({ x: shape.left_base_width_2, y: secondStepTop });

      // Walk left to first step
      points.push({ x: shape.left_base_width, y: secondStepTop });

      // Go up for first step
      points.push({ x: shape.left_base_width, y: firstStepTop });

      // Walk left to edge
      points.push({ x: 0, y: firstStepTop });
    } else {
      // Single step
      const firstStepTop = baseHeight - shape.left_base_height;

      // At bottom, walk left to where step starts
      points.push({ x: shape.left_base_width, y: baseHeight });

      // Go up for step
      points.push({ x: shape.left_base_width, y: firstStepTop });

      // Walk left to edge
      points.push({ x: 0, y: firstStepTop });
    }
  } else {
    // No left steps, walk straight across bottom
    points.push({ x: 0, y: baseHeight });
  }

  // Left edge - go back up to start (close the path)
  // Already at left edge, will connect back to start point

  return points;
}
