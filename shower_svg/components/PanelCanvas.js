import React, { useState, useRef } from 'react';
import { View, StyleSheet, PanResponder } from 'react-native';
import Svg, { Polygon, Line, G, Text as SvgText } from 'react-native-svg';
import { projectPanel, isPanelVisible } from '../utils/projection3D';

const PanelCanvas = ({ panels, currentPanelId }) => {
  const [scale, setScale] = useState(1);
  const [pan, setPan] = useState({ x: 0, y: 0 });
  const lastScale = useRef(1);
  const lastPan = useRef({ x: 0, y: 0 });
  const initialDistance = useRef(null);

  // Get current panel
  const currentPanel = panels.find(p => p.id === currentPanelId);

  // Show ALL panels - no filtering
  // This ensures we see all panels regardless of rotation
  const visiblePanels = panels;

  // No view rotation needed - panels are already rotated in the data
  const viewRotationY = 0;

  // Project visible panels to 2D and sort by depth (back to front)
  // Don't filter by visibility - show all panels even if facing away
  const projectedPanels = visiblePanels
    .map(panel => projectPanel(panel, viewRotationY))
    .sort((a, b) => a.avgZ - b.avgZ); // Sort by depth

  // Calculate automatic bounding box for all panels
  const bounds = projectedPanels.reduce((acc, p) => {
    p.corners.forEach(c => {
      acc.minX = Math.min(acc.minX, c.x);
      acc.maxX = Math.max(acc.maxX, c.x);
      acc.minY = Math.min(acc.minY, c.y);
      acc.maxY = Math.max(acc.maxY, c.y);
    });
    return acc;
  }, { minX: Infinity, maxX: -Infinity, minY: Infinity, maxY: -Infinity });

  // Add padding and calculate viewBox
  const padding = 100;
  const width = (bounds.maxX - bounds.minX + padding * 2) / scale;
  const height = (bounds.maxY - bounds.minY + padding * 2) / scale;
  const viewBoxX = bounds.minX - padding - pan.x / scale;
  const viewBoxY = bounds.minY - padding - pan.y / scale;
  const viewBox = `${viewBoxX} ${viewBoxY} ${width} ${height}`;

  // Pan and pinch gesture handler
  const panResponder = useRef(
    PanResponder.create({
      onStartShouldSetPanResponder: () => true,
      onMoveShouldSetPanResponder: () => true,
      onPanResponderGrant: () => {
        lastScale.current = scale;
        lastPan.current = pan;
      },
      onPanResponderMove: (evt, gestureState) => {
        // Handle pinch-to-zoom
        if (evt.nativeEvent.touches.length === 2) {
          const touch1 = evt.nativeEvent.touches[0];
          const touch2 = evt.nativeEvent.touches[1];
          const distance = Math.sqrt(
            Math.pow(touch2.pageX - touch1.pageX, 2) +
            Math.pow(touch2.pageY - touch1.pageY, 2)
          );

          if (!initialDistance.current) {
            initialDistance.current = distance;
          } else {
            const newScale = lastScale.current * (distance / initialDistance.current);
            setScale(Math.max(0.5, Math.min(5, newScale))); // Limit scale between 0.5x and 5x
          }
        } else {
          // Handle pan (single finger)
          setPan({
            x: lastPan.current.x + gestureState.dx,
            y: lastPan.current.y + gestureState.dy,
          });
        }
      },
      onPanResponderRelease: () => {
        initialDistance.current = null;
      },
    })
  ).current;

  return (
    <View style={styles.container} {...panResponder.panHandlers}>
      <Svg width={600} height={600} viewBox={viewBox}>
        {/* Draw connection lines */}
        {panels.map((panel) =>
          panel.connections.map((connection, idx) => {
            // Skip drawing lines for 0-degree connections (no panel on that side)
            if (connection.panelId === 0 || connection.angle === 0) return null;

            const connectedPanel = panels.find(p => p.id === connection.panelId);
            if (!connectedPanel) return null;

            const startX = panel.x + panel.width / 2;
            const startY = panel.y + panel.height / 2;
            const endX = connectedPanel.x + connectedPanel.width / 2;
            const endY = connectedPanel.y + connectedPanel.height / 2;

            return (
              <Line
                key={`${panel.id}-${connection.panelId}-${idx}`}
                x1={startX}
                y1={startY}
                x2={endX}
                y2={endY}
                stroke="#999"
                strokeWidth="1"
                strokeDasharray="4,4"
              />
            );
          })
        )}

        {/* Draw panels using 3D projection - outline only */}
        {projectedPanels.map((projectedPanel) => {
          const panel = projectedPanel.panel;
          const isCurrent = panel.id === currentPanelId;

          // Convert corners to polygon points string
          const points = projectedPanel.corners
            .map(c => `${c.x},${c.y}`)
            .join(' ');

          // Calculate center for label
          const centerX = projectedPanel.corners.reduce((sum, c) => sum + c.x, 0) / 4;
          const centerY = projectedPanel.corners.reduce((sum, c) => sum + c.y, 0) / 4;

          return (
            <G key={panel.id}>
              <Polygon
                points={points}
                fill="none"
                stroke={isCurrent ? "#007AFF" : "#333"}
                strokeWidth={isCurrent ? "3" : "2"}
                opacity={1}
              />
              <SvgText
                x={centerX}
                y={centerY}
                fill={isCurrent ? "#007AFF" : "#333"}
                fontSize="16"
                fontWeight="bold"
                textAnchor="middle"
                alignmentBaseline="middle"
              >
                {panel.id}
              </SvgText>
            </G>
          );
        })}
      </Svg>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 20,
  },
});

export default PanelCanvas;
