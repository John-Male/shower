import React from 'react';
import { View, StyleSheet } from 'react-native';
import Svg, { Polygon } from 'react-native-svg';
import { generatePanelShapePath } from '../utils/panelTypes';

/**
 * Renders a small preview of a panel shape
 */
const PanelShapePreview = ({ shape, size = 60, color = '#007AFF' }) => {
  if (!shape) return null;

  // Generate the path points for this shape
  const pathPoints = generatePanelShapePath(shape);

  // Calculate bounds to center and scale the shape
  const minX = Math.min(...pathPoints.map(p => p.x));
  const maxX = Math.max(...pathPoints.map(p => p.x));
  const minY = Math.min(...pathPoints.map(p => p.y));
  const maxY = Math.max(...pathPoints.map(p => p.y));

  const width = maxX - minX;
  const height = maxY - minY;

  // Scale to fit in the preview size with some padding
  const padding = 5;
  const scale = Math.min(
    (size - padding * 2) / width,
    (size - padding * 2) / height
  );

  // Convert points to SVG polygon format with scaling and centering
  const points = pathPoints
    .map(p => {
      const scaledX = (p.x - minX) * scale + padding;
      const scaledY = (p.y - minY) * scale + padding;
      return `${scaledX},${scaledY}`;
    })
    .join(' ');

  const viewBoxSize = size;

  return (
    <View style={[styles.container, { width: size, height: size }]}>
      <Svg width={size} height={size} viewBox={`0 0 ${viewBoxSize} ${viewBoxSize}`}>
        <Polygon
          points={points}
          fill="none"
          stroke={color}
          strokeWidth="2"
        />
      </Svg>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    backgroundColor: '#f9f9f9',
    borderRadius: 4,
    borderWidth: 1,
    borderColor: '#ddd',
  },
});

export default PanelShapePreview;
