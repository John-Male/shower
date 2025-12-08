import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ScrollView } from 'react-native';
import { PANEL_TYPES, PANEL_TYPE_LABELS, createDefaultPanelShape } from '../utils/panelTypes';
import PanelShapePreview from './PanelShapePreview';

const PanelControls = ({ panels, onPanelsChange }) => {
  const [selectedPanel, setSelectedPanel] = useState(null);
  const [newConnection, setNewConnection] = useState({
    panelId: '',
    angle: '180',
    side: 'right',
  });
  const [newPanelType, setNewPanelType] = useState(PANEL_TYPES.NORMAL);

  const addPanel = () => {
    // Generate a new panel ID based on existing panels
    const panelNumbers = panels.map(p => p.panelNumber || 0);
    const newPanelNumber = Math.max(...panelNumbers, 0) + 1;
    const newPanel = {
      id: `panel_${newPanelNumber}`,
      panelGroup: 'custom',
      panelNumber: newPanelNumber,
      width: 50,
      height: 100,
      x: 50,
      y: 50,
      z: 0,
      rotationY: 0,
      leftPanel: null,
      rightPanel: null,
      shape: createDefaultPanelShape(newPanelType, 50, 100),
      connections: [],
    };
    onPanelsChange([...panels, newPanel]);
  };

  const changePanelType = (panelId, newType) => {
    const panel = panels.find(p => p.id === panelId);
    if (!panel) return;

    const newShape = createDefaultPanelShape(newType, panel.width, panel.height);
    const updatedPanels = panels.map(p =>
      p.id === panelId ? { ...p, shape: newShape } : p
    );
    onPanelsChange(updatedPanels);
  };

  const removePanel = (panelId) => {
    const updatedPanels = panels
      .filter(p => p.id !== panelId)
      .map(p => ({
        ...p,
        connections: p.connections.filter(c => c.panelId !== panelId),
      }));
    onPanelsChange(updatedPanels);
    setSelectedPanel(null);
  };

  const updatePanel = (panelId, updates) => {
    const updatedPanels = panels.map(p =>
      p.id === panelId ? { ...p, ...updates } : p
    );
    onPanelsChange(updatedPanels);
  };

  const addConnection = () => {
    if (!selectedPanel || newConnection.panelId === '') return;

    const targetPanelId = newConnection.panelId;
    const angle = parseInt(newConnection.angle);

    // Allow panelId 0 (no panel), otherwise validate that panel exists
    if (targetPanelId !== '0' && targetPanelId !== 0 && !panels.find(p => p.id === targetPanelId)) return;

    const updatedPanels = panels.map(p => {
      if (p.id === selectedPanel.id) {
        return {
          ...p,
          connections: [
            ...p.connections,
            {
              panelId: targetPanelId === '0' ? 0 : targetPanelId,
              angle: angle,
              side: newConnection.side,
            },
          ],
        };
      }
      return p;
    });

    onPanelsChange(updatedPanels);
    setNewConnection({ panelId: '', angle: '180', side: 'right' });
  };

  const removeConnection = (panelId, connectionIndex) => {
    const updatedPanels = panels.map(p => {
      if (p.id === panelId) {
        return {
          ...p,
          connections: p.connections.filter((_, idx) => idx !== connectionIndex),
        };
      }
      return p;
    });
    onPanelsChange(updatedPanels);
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Add New Panel:</Text>
        <Text style={styles.label}>Select Panel Shape:</Text>
        <ScrollView horizontal style={styles.previewScrollView} showsHorizontalScrollIndicator={true}>
          <View style={styles.previewContainer}>
            {Object.entries(PANEL_TYPE_LABELS).map(([type, label]) => {
              const previewShape = createDefaultPanelShape(type, 50, 100);
              return (
                <TouchableOpacity
                  key={type}
                  style={[
                    styles.previewCard,
                    newPanelType === type && styles.previewCardSelected,
                  ]}
                  onPress={() => setNewPanelType(type)}
                >
                  <PanelShapePreview
                    shape={previewShape}
                    size={70}
                    color={newPanelType === type ? '#007AFF' : '#666'}
                  />
                  <Text style={[
                    styles.previewLabel,
                    newPanelType === type && styles.previewLabelSelected,
                  ]}>
                    {label}
                  </Text>
                </TouchableOpacity>
              );
            })}
          </View>
        </ScrollView>
        <TouchableOpacity style={styles.addButton} onPress={addPanel}>
          <Text style={styles.addButtonText}>+ Add Panel</Text>
        </TouchableOpacity>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Panels:</Text>
        {panels.map(panel => (
          <TouchableOpacity
            key={panel.id}
            style={[
              styles.panelItem,
              selectedPanel?.id === panel.id && styles.panelItemSelected,
            ]}
            onPress={() => setSelectedPanel(panel)}
          >
            <Text style={styles.panelItemText}>
              {panel.id} {panel.panelGroup ? `[${panel.panelGroup}]` : ''} ({panel.width}x{panel.height})
            </Text>
            <TouchableOpacity
              style={styles.removeButton}
              onPress={() => removePanel(panel.id)}
            >
              <Text style={styles.removeButtonText}>×</Text>
            </TouchableOpacity>
          </TouchableOpacity>
        ))}
      </View>

      {selectedPanel && (
        <View style={styles.section}>
          <Text style={styles.sectionTitle}>Edit Panel {selectedPanel.id}:</Text>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Width:</Text>
            <TextInput
              style={styles.input}
              value={String(selectedPanel.width)}
              onChangeText={(text) =>
                updatePanel(selectedPanel.id, { width: parseInt(text) || 40 })
              }
              keyboardType="numeric"
            />
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Height:</Text>
            <TextInput
              style={styles.input}
              value={String(selectedPanel.height)}
              onChangeText={(text) =>
                updatePanel(selectedPanel.id, { height: parseInt(text) || 100 })
              }
              keyboardType="numeric"
            />
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>X Position:</Text>
            <TextInput
              style={styles.input}
              value={String(selectedPanel.x)}
              onChangeText={(text) =>
                updatePanel(selectedPanel.id, { x: parseInt(text) || 0 })
              }
              keyboardType="numeric"
            />
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Y Position:</Text>
            <TextInput
              style={styles.input}
              value={String(selectedPanel.y)}
              onChangeText={(text) =>
                updatePanel(selectedPanel.id, { y: parseInt(text) || 0 })
              }
              keyboardType="numeric"
            />
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Z Position (depth):</Text>
            <TextInput
              style={styles.input}
              value={String(selectedPanel.z || 0)}
              onChangeText={(text) =>
                updatePanel(selectedPanel.id, { z: parseInt(text) || 0 })
              }
              keyboardType="numeric"
            />
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Rotation Y (degrees):</Text>
            <TextInput
              style={styles.input}
              value={String(selectedPanel.rotationY || 0)}
              onChangeText={(text) =>
                updatePanel(selectedPanel.id, { rotationY: parseInt(text) || 0 })
              }
              keyboardType="numeric"
              placeholder="0, 90, 180, 270"
            />
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Panel Group:</Text>
            <TextInput
              style={styles.input}
              value={String(selectedPanel.panelGroup || '')}
              onChangeText={(text) =>
                updatePanel(selectedPanel.id, { panelGroup: text })
              }
              placeholder="e.g., front1, left, right"
            />
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Panel Shape Type:</Text>
            <Text style={styles.currentTypeText}>
              Current: {PANEL_TYPE_LABELS[selectedPanel.shape?.type] || 'Normal'}
            </Text>
            <ScrollView horizontal style={styles.typeScrollView} showsHorizontalScrollIndicator={true}>
              <View style={styles.typeContainer}>
                {Object.entries(PANEL_TYPE_LABELS).map(([type, label]) => {
                  const previewShape = createDefaultPanelShape(type, 50, 100);
                  return (
                    <TouchableOpacity
                      key={type}
                      style={[
                        styles.typeCard,
                        selectedPanel.shape?.type === type && styles.typeCardSelected,
                      ]}
                      onPress={() => changePanelType(selectedPanel.id, type)}
                    >
                      <PanelShapePreview
                        shape={previewShape}
                        size={50}
                        color={selectedPanel.shape?.type === type ? '#007AFF' : '#666'}
                      />
                      <Text style={[
                        styles.typeLabel,
                        selectedPanel.shape?.type === type && styles.typeLabelSelected,
                      ]}>
                        {label}
                      </Text>
                    </TouchableOpacity>
                  );
                })}
              </View>
            </ScrollView>
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Left Panel (neighbor):</Text>
            <TextInput
              style={styles.input}
              value={String(selectedPanel.leftPanel || '')}
              onChangeText={(text) =>
                updatePanel(selectedPanel.id, { leftPanel: text || null })
              }
              placeholder="e.g., front1_11 or leave empty"
            />
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Right Panel (neighbor):</Text>
            <TextInput
              style={styles.input}
              value={String(selectedPanel.rightPanel || '')}
              onChangeText={(text) =>
                updatePanel(selectedPanel.id, { rightPanel: text || null })
              }
              placeholder="e.g., right_2 or leave empty"
            />
          </View>

          <Text style={styles.subsectionTitle}>Connections:</Text>
          {selectedPanel.connections.map((conn, idx) => (
            <View key={idx} style={styles.connectionItem}>
              <Text style={styles.connectionText}>
                → Panel {conn.panelId} ({conn.angle}°, {conn.side})
              </Text>
              <TouchableOpacity
                style={styles.removeButton}
                onPress={() => removeConnection(selectedPanel.id, idx)}
              >
                <Text style={styles.removeButtonText}>×</Text>
              </TouchableOpacity>
            </View>
          ))}

          <Text style={styles.subsectionTitle}>Add Connection:</Text>
          <View style={styles.inputRow}>
            <Text style={styles.label}>Panel ID (0 = no panel):</Text>
            <TextInput
              style={styles.input}
              value={newConnection.panelId}
              onChangeText={(text) =>
                setNewConnection({ ...newConnection, panelId: text })
              }
              placeholder="e.g., front1_1 or 0"
            />
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Angle:</Text>
            <View style={styles.angleButtons}>
              {[0, 90, 135, 180].map(angle => (
                <TouchableOpacity
                  key={angle}
                  style={[
                    styles.angleButton,
                    newConnection.angle === String(angle) && styles.angleButtonSelected,
                  ]}
                  onPress={() => setNewConnection({ ...newConnection, angle: String(angle) })}
                >
                  <Text style={styles.angleButtonText}>{angle}°</Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>

          <View style={styles.inputRow}>
            <Text style={styles.label}>Side:</Text>
            <View style={styles.angleButtons}>
              {['top', 'right', 'bottom', 'left'].map(side => (
                <TouchableOpacity
                  key={side}
                  style={[
                    styles.angleButton,
                    newConnection.side === side && styles.angleButtonSelected,
                  ]}
                  onPress={() => setNewConnection({ ...newConnection, side })}
                >
                  <Text style={styles.angleButtonText}>{side}</Text>
                </TouchableOpacity>
              ))}
            </View>
          </View>

          <TouchableOpacity style={styles.addConnectionButton} onPress={addConnection}>
            <Text style={styles.addConnectionButtonText}>Add Connection</Text>
          </TouchableOpacity>
        </View>
      )}
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 20,
    backgroundColor: '#fff',
  },
  section: {
    marginBottom: 20,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  subsectionTitle: {
    fontSize: 14,
    fontWeight: '600',
    marginTop: 15,
    marginBottom: 8,
  },
  addButton: {
    backgroundColor: '#007AFF',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
  },
  addButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  panelItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 12,
    backgroundColor: '#f5f5f5',
    borderRadius: 8,
    marginBottom: 8,
  },
  panelItemSelected: {
    backgroundColor: '#e3f2fd',
    borderWidth: 2,
    borderColor: '#007AFF',
  },
  panelItemText: {
    fontSize: 14,
  },
  removeButton: {
    width: 24,
    height: 24,
    backgroundColor: '#ff3b30',
    borderRadius: 12,
    alignItems: 'center',
    justifyContent: 'center',
  },
  removeButtonText: {
    color: '#fff',
    fontSize: 18,
    fontWeight: 'bold',
  },
  inputRow: {
    marginBottom: 12,
  },
  label: {
    fontSize: 14,
    fontWeight: '600',
    marginBottom: 4,
  },
  input: {
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    padding: 10,
    fontSize: 14,
  },
  connectionItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 8,
    backgroundColor: '#f9f9f9',
    borderRadius: 6,
    marginBottom: 6,
  },
  connectionText: {
    fontSize: 13,
  },
  angleButtons: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  angleButton: {
    paddingHorizontal: 12,
    paddingVertical: 8,
    backgroundColor: '#f5f5f5',
    borderRadius: 6,
    borderWidth: 1,
    borderColor: '#ddd',
  },
  angleButtonSelected: {
    backgroundColor: '#007AFF',
    borderColor: '#007AFF',
  },
  angleButtonText: {
    fontSize: 12,
  },
  addConnectionButton: {
    backgroundColor: '#34c759',
    padding: 12,
    borderRadius: 8,
    alignItems: 'center',
    marginTop: 10,
  },
  addConnectionButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '600',
  },
  previewScrollView: {
    marginBottom: 15,
    maxHeight: 150,
  },
  previewContainer: {
    flexDirection: 'row',
    paddingVertical: 10,
    gap: 12,
  },
  previewCard: {
    alignItems: 'center',
    padding: 10,
    backgroundColor: '#fff',
    borderRadius: 8,
    borderWidth: 2,
    borderColor: '#ddd',
    marginRight: 10,
    width: 100,
  },
  previewCardSelected: {
    borderColor: '#007AFF',
    backgroundColor: '#e3f2fd',
  },
  previewLabel: {
    fontSize: 10,
    textAlign: 'center',
    marginTop: 6,
    color: '#666',
  },
  previewLabelSelected: {
    color: '#007AFF',
    fontWeight: '600',
  },
  typeScrollView: {
    marginTop: 8,
    maxHeight: 120,
  },
  typeContainer: {
    flexDirection: 'row',
    gap: 8,
  },
  typeCard: {
    alignItems: 'center',
    padding: 8,
    backgroundColor: '#fff',
    borderRadius: 6,
    borderWidth: 2,
    borderColor: '#ddd',
    marginRight: 8,
    width: 80,
  },
  typeCardSelected: {
    borderColor: '#007AFF',
    backgroundColor: '#e3f2fd',
  },
  typeLabel: {
    fontSize: 9,
    textAlign: 'center',
    marginTop: 4,
    color: '#666',
  },
  typeLabelSelected: {
    color: '#007AFF',
    fontWeight: '600',
  },
  currentTypeText: {
    fontSize: 13,
    color: '#666',
    marginBottom: 8,
    fontStyle: 'italic',
  },
});

export default PanelControls;
