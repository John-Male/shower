import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert } from 'react-native';
import Svg, { Rect, Circle, Line, Polygon, G, Defs, LinearGradient, Stop } from 'react-native-svg';

const MobileShowerViewer = () => {
  // Configuration state
  const [showConfiguration, setShowConfiguration] = useState(true);
  const [showerConfig, setShowerConfig] = useState({
    arrangement: 'u-shape', // 'straight', 'u-shape', 'angled-135'
    panels: {
      front: ['front-left', 'Door R'], // Array of panel IDs including doors
      left: ['left'],
      right: ['right'],
      back: [] // No back panels in current U-shape
    }
  });

  // Viewer state
  const [view, setView] = useState('iso3d');
  const [rotation, setRotation] = useState(225); // Start with front panels in foreground
  const [showDetails, setShowDetails] = useState(false);
  const [doorOpen, setDoorOpen] = useState(false);
  const [focusPanel, setFocusPanel] = useState('Door R');

  // Panel rotations - clockwise around shower including doors
  const getPanelRotation = (panelId, wall) => {
    // Predefined rotations
    const baseRotations = {
      'right': 315,           // Right wall panel
      'Door L': 225,          // Left opening door
      'Door R': 225,          // Right opening door  
      'front-left': 225,      // Front left panel
      'left': 135,            // Left wall panel
      // Straight line panels
      'panel-1': 225,         // First panel in straight line
      'panel-2': 225,         // Second panel in straight line
      'panel-3': 225,         // Third panel in straight line
    };
    
    // If predefined rotation exists, use it
    if (baseRotations[panelId] !== undefined) {
      return baseRotations[panelId];
    }
    
    // Dynamic rotation based on wall
    switch (wall) {
      case 'front': return 225;
      case 'right': return 315;
      case 'back': return 45;
      case 'left': return 135;
      default: return 225;
    }
  };

  // Create dynamic panel rotations object
  const panelRotations = {};
  Object.entries(showerConfig.panels).forEach(([wall, panels]) => {
    panels.forEach(panelId => {
      panelRotations[panelId] = getPanelRotation(panelId, wall);
    });
  });

  // Update rotation when focus panel changes
  useEffect(() => {
    if (focusPanel && panelRotations[focusPanel] !== undefined && !isNaN(panelRotations[focusPanel])) {
      setRotation(panelRotations[focusPanel]);
    } else {
      // Default rotation if panel not found or invalid
      setRotation(225);
    }
  }, [focusPanel]);

  // Configuration functions
  const updateArrangement = (arrangement) => {
    let newPanels = {};
    
    switch(arrangement) {
      case 'straight':
        newPanels = {
          front: ['panel-1', 'panel-2', 'panel-3', 'Door R'],
          left: [],
          right: [],
          back: []
        };
        break;
      case 'u-shape':
        newPanels = {
          front: ['front-left', 'Door R'],
          left: ['left'],
          right: ['right'],
          back: []
        };
        break;
      case 'angled-135':
        newPanels = {
          front: ['front-left', 'Door R'],
          left: ['left'],
          right: ['right'],
          back: ['back-left', 'back-right']
        };
        break;
    }
    
    setShowerConfig(prev => ({
      ...prev,
      arrangement,
      panels: newPanels
    }));
    
    // Update focus panel to a valid panel for the new arrangement
    // Find a door in any wall to focus on
    const allPanels = [...newPanels.front, ...newPanels.left, ...newPanels.right, ...newPanels.back];
    const doorPanel = allPanels.find(panel => panel.startsWith('Door'));
    
    if (doorPanel) {
      setFocusPanel(doorPanel); // Focus on door
    } else if (newPanels.front.length > 0) {
      setFocusPanel(newPanels.front[0]); // Focus on first front panel
    }
  };

  const addPanel = (wall, panelId) => {
    // Show selection for all walls including door options
    const panelCount = showerConfig.panels[wall].length;
    const regularPanelId = wall === 'doors' ? 'door' : `${wall}-panel-${panelCount + 1}`;
    
    const options = [];
    
    if (wall !== 'doors') {
      // Add regular panel option for non-door walls
      options.push({
        text: `${wall.charAt(0).toUpperCase() + wall.slice(1)} Panel`,
        onPress: () => {
          setShowerConfig(prev => ({
            ...prev,
            panels: {
              ...prev.panels,
              [wall]: [...prev.panels[wall], regularPanelId]
            }
          }));
        }
      });
    }
    
    // Add door options for all walls
    options.push(
      {
        text: "Door L (Left Opening)",
        onPress: () => {
          setShowerConfig(prev => ({
            ...prev,
            panels: {
              ...prev.panels,
              [wall]: [...prev.panels[wall], 'Door L']
            }
          }));
        }
      },
      {
        text: "Door R (Right Opening)", 
        onPress: () => {
          setShowerConfig(prev => ({
            ...prev,
            panels: {
              ...prev.panels,
              [wall]: [...prev.panels[wall], 'Door R']
            }
          }));
        }
      },
      {
        text: "Double Doors (L+R)",
        onPress: () => {
          setShowerConfig(prev => ({
            ...prev,
            panels: {
              ...prev.panels,
              [wall]: [...prev.panels[wall], 'Door L', 'Door R']
            }
          }));
        }
      },
      {
        text: "Cancel",
        style: "cancel"
      }
    );
    
    Alert.alert(
      "Add Panel",
      `Choose what to add to the ${wall === 'doors' ? 'shower' : wall + ' wall'}:`,
      options
    );
  };

  const showDoorTypeSelection = () => {
    Alert.alert(
      "Add Door",
      "Select door type (all doors open outward):",
      [
        {
          text: "Left Opening Door",
          onPress: () => addDoorPanel('door-left-opening')
        },
        {
          text: "Right Opening Door", 
          onPress: () => addDoorPanel('door-right-opening')
        },
        {
          text: "Double Doors",
          onPress: () => addDoubleDoors()
        },
        {
          text: "Cancel",
          style: "cancel"
        }
      ]
    );
  };



  const removePanel = (wall, panelIndex) => {
    setShowerConfig(prev => ({
      ...prev,
      panels: {
        ...prev.panels,
        [wall]: prev.panels[wall].filter((_, index) => index !== panelIndex)
      }
    }));
  };

  const ConfigurationScreen = () => {
    return (
      <ScrollView contentContainerStyle={styles.configContainer}>
        <Text style={styles.configTitle}>Shower Configuration</Text>
      
      {/* Arrangement Selection */}
      <View style={styles.configSection}>
        <Text style={styles.configSectionTitle}>Panel Arrangement</Text>
        <View style={styles.configOptions}>
          {[
            { id: 'straight', label: 'Straight Line', icon: '▬' },
            { id: 'u-shape', label: 'U-Shape', icon: '⊔' },
            { id: 'angled-135', label: '135° Angled', icon: '⟨⟩' }
          ].map(option => (
            <TouchableOpacity
              key={option.id}
              style={[styles.configOption, showerConfig.arrangement === option.id && styles.configOptionActive]}
              onPress={() => updateArrangement(option.id)}
            >
              <Text style={styles.configOptionIcon}>{option.icon}</Text>
              <Text style={styles.configOptionText}>{option.label}</Text>
            </TouchableOpacity>
          ))}
        </View>
      </View>

      {/* Panel Management */}
      <View style={styles.configSection}>
        <Text style={styles.configSectionTitle}>Panel Management</Text>
        {Object.entries(showerConfig.panels).filter(([wall]) => wall !== 'doors').map(([wall, panels]) => (
          <View key={wall} style={styles.wallSection}>
            <Text style={styles.wallTitle}>
               {`${wall.charAt(0).toUpperCase() + wall.slice(1)} Wall`}
            </Text>
            <View style={styles.panelList}>
              {panels.map((panelId, index) => (
                <View key={index} style={styles.panelItem}>
                  <Text style={styles.panelText}>
                    {panelId.startsWith('Door') ? `🚪 ${panelId}` : panelId}
                  </Text>
                  <TouchableOpacity
                    style={styles.removeButton}
                    onPress={() => removePanel(wall, index)}
                  >
                    <Text style={styles.removeButtonText}>✕</Text>
                  </TouchableOpacity>
                </View>
              ))}
              <TouchableOpacity
                style={styles.addButton}
                onPress={() => addPanel(wall, `${wall}-panel-${panels.filter(p => !p.startsWith('Door')).length + 1}`)}
              >
                <Text style={styles.addButtonText}>
                  + Add Panel
                </Text>
              </TouchableOpacity>
            </View>
          </View>
        ))}
      </View>

      {/* Start Viewer Button */}
      <TouchableOpacity
        style={styles.startViewerButton}
        onPress={() => setShowConfiguration(false)}
      >
        <Text style={styles.startViewerButtonText}>🚿 Start 3D Viewer</Text>
      </TouchableOpacity>
    </ScrollView>
    );
  };

  // Helper function to convert 3D coords to 2D isometric projection
  const iso3D = (x, y, z) => {
    const angle = (panelRotations[focusPanel] * Math.PI) / 180;
    const cos = Math.cos(angle);
    const sin = Math.sin(angle);
    
    // Isometric projection with rotation
    const isoX = (x * cos - z * sin) * 0.866;
    const isoY = y * 0.5 + (x * sin + z * cos) * 0.5;
    
    return { x: isoX + 150, y: 100 - isoY };
  };

  // Function to cycle through all available panels including doors
  const rotateToPanel = (direction) => {
    // Get all available panels from the current configuration
    const allPanels = [];
    
    // Add panels clockwise: front → right → back → left (doors are mixed in)
    allPanels.push(...(showerConfig.panels.front || []));
    allPanels.push(...(showerConfig.panels.right || []));
    allPanels.push(...(showerConfig.panels.back || []));
    allPanels.push(...(showerConfig.panels.left || []));
    
    // Filter out any invalid panel names
    const validPanels = allPanels.filter(panel => 
      panel && typeof panel === 'string' && panel.length > 0
    );
    
    if (validPanels.length === 0) {
      return; // No valid panels to rotate to
    }
    
    const currentIndex = validPanels.indexOf(focusPanel);
    let newIndex;
    
    if (currentIndex === -1) {
      // Current panel not found, go to first panel
      newIndex = 0;
    } else if (direction === 'left') { // Counter-clockwise (prev)
      newIndex = (currentIndex - 1 + validPanels.length) % validPanels.length;
    } else { // Clockwise (next)  
      newIndex = (currentIndex + 1) % validPanels.length;
    }
    
    const newPanel = validPanels[newIndex];
    if (newPanel && panelRotations[newPanel] !== undefined) {
      setFocusPanel(newPanel);
    }
  };

  // Function to get panel coordinates based on wall and position
  const getPanelCoordinates = (wall, panelIndex, totalPanels, panelId, isDoorOpen = false) => {
    const panelWidth = 150 / Math.max(totalPanels, 1); // Distribute width based on number of panels
    const isDoor = panelId.startsWith('Door');
    
    // Add safety checks to prevent invalid coordinates
    if (panelIndex < 0 || totalPanels <= 0 || panelWidth <= 0) {
      return [];
    }
    
    // Check if we're in 135-degree arrangement
    const is135Degree = showerConfig.arrangement === 'angled-135';
    
    switch (wall) {
      case 'front':
        let frontStartX = -75 + (panelIndex * panelWidth);
        let frontEndX = frontStartX + panelWidth;
        
        // Ensure coordinates are within bounds
        frontStartX = Math.max(-75, Math.min(75, frontStartX));
        frontEndX = Math.max(-75, Math.min(75, frontEndX));
        
        // Ensure we have a valid width
        if (frontEndX <= frontStartX) {
          frontEndX = frontStartX + Math.min(panelWidth, 10); // Minimum width of 10
        }
        
        // Handle door opening animation for front wall doors
        if (isDoor && isDoorOpen) {
          const doorAngle = panelId === 'Door L' ? -75 : 75; // Left opens left, Right opens right
          const doorRadians = (doorAngle * Math.PI) / 180;
          const hingeX = panelId === 'Door L' ? frontStartX : frontEndX;
          const doorWidth = Math.abs(frontEndX - frontStartX);
          
          return [
            iso3D(hingeX + doorWidth * Math.cos(doorRadians), -10, 50 + doorWidth * Math.sin(doorRadians)),
            iso3D(hingeX, -10, 50), // Hinge point
            iso3D(hingeX, 80, 50), // Hinge point
            iso3D(hingeX + doorWidth * Math.cos(doorRadians), 80, 50 + doorWidth * Math.sin(doorRadians))
          ];
        }
        
        return [
          iso3D(frontStartX, -10, 50), iso3D(frontEndX, -10, 50),
          iso3D(frontEndX, 80, 50), iso3D(frontStartX, 80, 50)
        ];
      
      case 'left':
        if (is135Degree) {
          // For 135-degree arrangement, angle the left wall inward
          const leftStartY = -10 + (panelIndex * (60 / Math.max(totalPanels, 1)));
          const leftEndY = leftStartY + (60 / Math.max(totalPanels, 1));
          const angleOffset = 25; // Create angled positioning
          return [
            iso3D(-50, leftStartY - angleOffset, 50), iso3D(-50, leftEndY - angleOffset, 50),
            iso3D(-50, leftEndY - angleOffset, -50), iso3D(-50, leftStartY - angleOffset, -50)
          ];
        } else {
          const leftStartY = -10 + (panelIndex * (90 / Math.max(totalPanels, 1)));
          const leftEndY = leftStartY + (90 / Math.max(totalPanels, 1));
          return [
            iso3D(-75, leftStartY, 50), iso3D(-75, leftEndY, 50),
            iso3D(-75, leftEndY, -50), iso3D(-75, leftStartY, -50)
          ];
        }
      
      case 'right':
        if (is135Degree) {
          // For 135-degree arrangement, angle the right wall inward
          const rightStartY = -10 + (panelIndex * (60 / Math.max(totalPanels, 1)));
          const rightEndY = rightStartY + (60 / Math.max(totalPanels, 1));
          const angleOffset = 25; // Create angled positioning
          return [
            iso3D(50, rightStartY - angleOffset, -50), iso3D(50, rightEndY - angleOffset, -50),
            iso3D(50, rightEndY - angleOffset, 50), iso3D(50, rightStartY - angleOffset, 50)
          ];
        } else {
          const rightStartY = -10 + (panelIndex * (90 / Math.max(totalPanels, 1)));
          const rightEndY = rightStartY + (90 / Math.max(totalPanels, 1));
          return [
            iso3D(75, rightStartY, -50), iso3D(75, rightEndY, -50),
            iso3D(75, rightEndY, 50), iso3D(75, rightStartY, 50)
          ];
        }
      
      case 'back':
        if (is135Degree) {
          // For 135-degree arrangement, adjust back wall positioning
          const backStartX = -50 + (panelIndex * panelWidth);
          const backEndX = backStartX + panelWidth;
          return [
            iso3D(backStartX, 55, 50), iso3D(backEndX, 55, 50),
            iso3D(backEndX, 55, -50), iso3D(backStartX, 55, -50)
          ];
        } else {
          const backStartX = -75 + (panelIndex * panelWidth);
          const backEndX = backStartX + panelWidth;
          return [
            iso3D(backStartX, 80, 50), iso3D(backEndX, 80, 50),
            iso3D(backEndX, 80, -50), iso3D(backStartX, 80, -50)
          ];
        }
      
      default:
        return [];
    }
  };

  const Isometric3DView = () => {
    // Define 3D coordinates for shower components
    const base = [
      iso3D(-75, -10, -50), iso3D(75, -10, -50),
      iso3D(75, -10, 50), iso3D(-75, -10, 50)
    ];
    

    
    // Door configuration - find doors across all walls
    const allPanels = [...showerConfig.panels.front, ...showerConfig.panels.left, ...showerConfig.panels.right, ...showerConfig.panels.back];
    const doors = allPanels.filter(panel => panel.startsWith('Door'));
    const hasDoors = doors.length > 0;
    const isDoorOpen = doorOpen && hasDoors;
    
    // Check door types from panel names
    const hasLeftDoor = doors.some(door => door === 'Door L');
    const hasRightDoor = doors.some(door => door === 'Door R');
    const hasDoubleDoors = hasLeftDoor && hasRightDoor;
    

    
    return (
      <Svg width="300" height="200" viewBox="0 0 300 200" style={styles.svg}>
        <Defs>
          <LinearGradient id="floorGrad" x1="0%" y1="0%" x2="100%" y2="100%">
            <Stop offset="0%" stopColor="#ff4444" />
            <Stop offset="100%" stopColor="#cc0000" />
          </LinearGradient>
          <LinearGradient id="wallGrad" x1="0%" y1="0%" x2="100%" y2="100%">
            <Stop offset="0%" stopColor="#b8d4f0" />
            <Stop offset="100%" stopColor="#7fb3d9" />
          </LinearGradient>
        </Defs>
        
        {/* Shower base (red floor) with 3D depth */}
        <Polygon 
          points={`${base[0].x},${base[0].y} ${base[1].x},${base[1].y} ${base[2].x},${base[2].y} ${base[3].x},${base[3].y}`}
          fill="url(#floorGrad)" 
          stroke="#990000" 
          strokeWidth="2"
        />
        
        {/* Dynamic panel rendering for all walls */}
        {Object.entries(showerConfig.panels).map(([wall, panels]) => 
          panels.map((panelId, index) => {
            if (!panelId || typeof panelId !== 'string') return null;
            
            const isDoor = panelId.startsWith('Door');
            const panelCoords = getPanelCoordinates(wall, index, panels.length, panelId, doorOpen && isDoor);
            
            // Validate coordinates to prevent rendering issues
            if (panelCoords.length !== 4) return null;
            
            const validCoords = panelCoords.every(coord => 
              coord && 
              typeof coord.x === 'number' && 
              typeof coord.y === 'number' && 
              !isNaN(coord.x) && 
              !isNaN(coord.y)
            );
            
            if (!validCoords) return null;
            
            return (
              <Polygon 
                key={`${wall}-${panelId}-${index}`}
                points={`${panelCoords[0].x},${panelCoords[0].y} ${panelCoords[1].x},${panelCoords[1].y} ${panelCoords[2].x},${panelCoords[2].y} ${panelCoords[3].x},${panelCoords[3].y}`}
                fill={focusPanel === panelId ? "#a8d0f0" : (isDoor && doorOpen ? "#cce6ff" : isDoor ? "#e6f3ff" : "url(#wallGrad)")} 
                stroke={focusPanel === panelId ? "#0066cc" : (isDoor ? "#0088ff" : "#999")} 
                strokeWidth={focusPanel === panelId ? "3" : (isDoor ? "2" : "1")}
                onPress={() => setFocusPanel(panelId)}
              />
            );
          })
        )}

        
        {/* Door hardware - handles and hinges based on door configuration */}
        {hasDoors && (
          <>
            {hasDoubleDoors ? (
              <>
                {/* Double door handles - center handles when closed */}
                {!isDoorOpen && (
                  <>
                    <Line 
                      x1={iso3D(32, 35, 50).x} y1={iso3D(32, 35, 50).y}
                      x2={iso3D(32, 45, 50).x} y2={iso3D(32, 45, 50).y}
                      stroke="#666" strokeWidth="3" strokeLinecap="round"
                    />
                    <Line 
                      x1={iso3D(43, 35, 50).x} y1={iso3D(43, 35, 50).y}
                      x2={iso3D(43, 45, 50).x} y2={iso3D(43, 45, 50).y}
                      stroke="#666" strokeWidth="3" strokeLinecap="round"
                    />
                  </>
                )}
                
                {/* Double door hinges */}
                <Line 
                  x1={iso3D(0, -10, 50).x} y1={iso3D(0, -10, 50).y}
                  x2={iso3D(0, 80, 50).x} y2={iso3D(0, 80, 50).y}
                  stroke="#333" strokeWidth="2"
                />
                <Line 
                  x1={iso3D(75, -10, 50).x} y1={iso3D(75, -10, 50).y}
                  x2={iso3D(75, 80, 50).x} y2={iso3D(75, 80, 50).y}
                  stroke="#333" strokeWidth="2"
                />
                
                {/* Center divider line between doors */}
                {!isDoorOpen && (
                  <Line 
                    x1={iso3D(37.5, -10, 50).x} y1={iso3D(37.5, -10, 50).y}
                    x2={iso3D(37.5, 80, 50).x} y2={iso3D(37.5, 80, 50).y}
                    stroke="#999" strokeWidth="1" strokeDasharray="5,5"
                  />
                )}
              </>
            ) : (
              <>
                {/* Single door handle - opposite side from hinge */}
                {!isDoorOpen && (
                  <Line 
                    x1={iso3D(showerConfig.doorSide === 'right' ? 10 : 65, 35, 50).x} 
                    y1={iso3D(showerConfig.doorSide === 'right' ? 10 : 65, 35, 50).y}
                    x2={iso3D(showerConfig.doorSide === 'right' ? 10 : 65, 45, 50).x} 
                    y2={iso3D(showerConfig.doorSide === 'right' ? 10 : 65, 45, 50).y}
                    stroke="#666" 
                    strokeWidth="3"
                    strokeLinecap="round"
                  />
                )}
                
                {/* Single door hinge line */}
                <Line 
                  x1={iso3D(showerConfig.doorSide === 'right' ? 75 : 0, -10, 50).x} 
                  y1={iso3D(showerConfig.doorSide === 'right' ? 75 : 0, -10, 50).y}
                  x2={iso3D(showerConfig.doorSide === 'right' ? 75 : 0, 80, 50).x} 
                  y2={iso3D(showerConfig.doorSide === 'right' ? 75 : 0, 80, 50).y}
                  stroke="#333" 
                  strokeWidth="2"
                />
              </>
            )}
          </>
        )}
        

      </Svg>
    );
  };

  const TopView = () => (
    <Svg width="300" height="200" viewBox="0 0 300 200" style={styles.svg}>
      {/* Shower base (red as requested) */}
      <Rect x="50" y="50" width="200" height="100" fill="#ff0000" stroke="#000" strokeWidth="2"/>
      
      {/* Left wall */}
      <Rect x="45" y="45" width="5" height="110" fill="#9cc5e8" stroke="#000" strokeWidth="1"/>
      
      {/* Right wall */}
      <Rect x="250" y="45" width="5" height="110" fill="#9cc5e8" stroke="#000" strokeWidth="1"/>
      
      {/* Back wall - left panel */}
      <Rect x="50" y="45" width="100" height="5" fill="#9cc5e8" stroke="#000" strokeWidth="1"/>
      
      {/* Back wall - door panel */}
      {doorOpen ? (
        // Door open - rotated to the right from right hinge
        <Polygon 
          points="250,50 290,80 290,85 250,55"
          fill="#e6f3ff" 
          stroke="#000" 
          strokeWidth="1"
        />
      ) : (
        // Door closed
        <Rect x="150" y="45" width="100" height="5" fill="#9cc5e8" stroke="#000" strokeWidth="1"/>
      )}
      
      {/* Door handle (when closed) - on left side of door panel */}
      {!doorOpen && (
        <Line 
          x1="170" y1="46" 
          x2="170" y2="49" 
          stroke="#666" 
          strokeWidth="2"
          strokeLinecap="round"
        />
      )}
    </Svg>
  );

  const SideView = () => (
    <Svg width="300" height="200" viewBox="0 0 300 200" style={styles.svg}>
      {/* Floor (red) */}
      <Rect x="50" y="160" width="200" height="10" fill="#ff0000" stroke="#000" strokeWidth="2"/>
      
      {/* Back wall */}
      <Rect x="50" y="60" width="5" height="100" fill="#9cc5e8" stroke="#000" strokeWidth="1"/>
      
      {/* Shower pole */}
      <Line x1="80" y1="80" x2="80" y2="160" stroke="#888888" strokeWidth="3"/>
      
      {/* Shower head */}
      <Circle cx="80" cy="80" r="6" fill="#666666"/>
      

      
      {/* Labels */}
      <Text x="150" y="190" textAnchor="middle" fontSize="12" fill="#333">Side View</Text>
    </Svg>
  );

  // Show configuration screen first
  if (showConfiguration) {
    return <ConfigurationScreen />;
  }

  return (
    <ScrollView contentContainerStyle={styles.container}>
      <View style={styles.header}>
        <TouchableOpacity
          style={styles.configButton}
          onPress={() => setShowConfiguration(true)}
        >
          <Text style={styles.configButtonText}>⚙️ Configure</Text>
        </TouchableOpacity>
        <Text style={styles.title}>Shower 3D Viewer</Text>
      </View>

      <View style={styles.controlsContainer}>
        <Text style={styles.focusLabel}>
          Focused: {
            focusPanel === 'Door L' ? '🚪 Door L (Left Opening)' :
            focusPanel === 'Door R' ? '🚪 Door R (Right Opening)' :
            focusPanel === 'front-left' ? 'Front Left Panel' :
            focusPanel.startsWith('panel-') ? `Panel ${focusPanel.split('-')[1]}` :
            focusPanel.startsWith('Door') ? `🚪 ${focusPanel}` :
            focusPanel.charAt(0).toUpperCase() + focusPanel.slice(1) + ' Panel'
          }
        </Text>
        
        <View style={styles.navigationControls}>
          <TouchableOpacity
            style={styles.arrowButton}
            onPress={() => rotateToPanel('left')}
          >
            <Text style={styles.arrowText}>← Prev Panel</Text>
          </TouchableOpacity>
          
          <TouchableOpacity
            style={styles.arrowButton}
            onPress={() => rotateToPanel('right')}
          >
            <Text style={styles.arrowText}>Next Panel →</Text>
          </TouchableOpacity>
        </View>
        
        {(() => {
          const allPanels = [...showerConfig.panels.front, ...showerConfig.panels.left, ...showerConfig.panels.right, ...showerConfig.panels.back];
          const doors = allPanels.filter(panel => panel.startsWith('Door'));
          const hasLeftDoor = doors.some(door => door === 'Door L');
          const hasRightDoor = doors.some(door => door === 'Door R');
          const hasDoubleDoors = hasLeftDoor && hasRightDoor;
          
          return doors.length > 0 && (
            <TouchableOpacity
              style={styles.doorButton}
              onPress={() => setDoorOpen(!doorOpen)}
            >
              <Text style={styles.doorButtonText}>
                {hasDoubleDoors ? '🚪🚪' : '🚪'} {
                  doorOpen ? 
                    (hasDoubleDoors ? 'Close Doors' : 'Close Door') : 
                    `Open ${hasDoubleDoors ? 'Doors' : 'Door'} (Outward)`
                }
              </Text>
            </TouchableOpacity>
          );
        })()}
      </View>

      <View style={styles.viewerContainer}>
        <Isometric3DView />
      </View>

      <TouchableOpacity 
        style={styles.detailsButton}
        onPress={() => setShowDetails(!showDetails)}
      >
        <Text style={styles.detailsButtonText}>
          {showDetails ? 'Hide Details' : 'Show Details'}
        </Text>
      </TouchableOpacity>

      {showDetails && (
        <View style={styles.details}>
          <Text style={styles.detailsTitle}>3D Shower Enclosure Features:</Text>
          <Text style={styles.detailItem}>🔴 Red Base/Floor - 3D isometric projection</Text>
          <Text style={styles.detailItem}>💙 Blue Walls - Muted blue side walls with gradient depth</Text>
          <Text style={styles.detailItem}>🏠 Back Wall - Two-panel design with door</Text>
          <Text style={styles.detailItem}>🚪 Opening Door - Right panel opens 75° to the right</Text>
          <Text style={styles.detailItem}>🔧 Door Handle - Interactive entry/exit</Text>
          <Text style={styles.detailItem}>🔄 360° Rotation - True 3D simulation using 2D projections</Text>
        </View>
      )}

      <Text style={styles.note}>
        For full 3D interactive experience, use the web version at localhost:8082
      </Text>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flexGrow: 1,
    padding: 20,
    backgroundColor: '#f5f5f5',
    alignItems: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
    color: '#333',
  },
  viewSelector: {
    flexDirection: 'row',
    marginBottom: 20,
  },
  viewButton: {
    paddingHorizontal: 20,
    paddingVertical: 10,
    backgroundColor: '#ddd',
    marginHorizontal: 5,
    borderRadius: 5,
  },
  activeView: {
    backgroundColor: '#0066cc',
  },
  viewButtonText: {
    color: '#333',
    fontWeight: 'bold',
  },
  viewerContainer: {
    backgroundColor: '#fff',
    padding: 20,
    borderRadius: 10,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.25,
    shadowRadius: 3.84,
    elevation: 5,
    marginBottom: 20,
  },
  svg: {
    backgroundColor: '#f9f9f9',
  },
  detailsButton: {
    backgroundColor: '#0066cc',
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 5,
    marginBottom: 20,
  },
  detailsButtonText: {
    color: '#fff',
    fontWeight: 'bold',
  },
  details: {
    backgroundColor: '#fff',
    padding: 15,
    borderRadius: 5,
    marginBottom: 20,
    width: '100%',
  },
  detailsTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#333',
  },
  detailItem: {
    fontSize: 14,
    marginBottom: 5,
    color: '#666',
  },
  rotationControl: {
    width: '100%',
    paddingHorizontal: 20,
    marginBottom: 15,
  },
  rotationLabel: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    textAlign: 'center',
    marginBottom: 10,
  },
  rotationButtons: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
    gap: 5,
  },
  angleButton: {
    paddingHorizontal: 8,
    paddingVertical: 5,
    backgroundColor: '#ddd',
    borderRadius: 3,
    minWidth: 35,
  },
  activeAngle: {
    backgroundColor: '#0066cc',
  },
  angleText: {
    fontSize: 10,
    textAlign: 'center',
    color: '#333',
  },
  doorButton: {
    backgroundColor: '#28a745',
    paddingHorizontal: 20,
    paddingVertical: 10,
    borderRadius: 5,
    marginTop: 15,
    alignSelf: 'center',
  },
  doorButtonText: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: 16,
  },
  controlsContainer: {
    width: '100%',
    alignItems: 'center',
    marginBottom: 20,
  },
  focusLabel: {
    fontSize: 16,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 10,
  },
  navigationControls: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 40,
    marginBottom: 20,
  },
  arrowButton: {
    backgroundColor: '#007AFF',
    paddingHorizontal: 15,
    paddingVertical: 10,
    borderRadius: 20,
    minWidth: 80,
    alignItems: 'center',
  },
  arrowText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 14,
  },
  centerButton: {
    backgroundColor: '#FF9500',
    paddingHorizontal: 15,
    paddingVertical: 10,
    borderRadius: 20,
    alignItems: 'center',
  },
  centerText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 14,
  },

  note: {
    fontSize: 12,
    color: '#888',
    textAlign: 'center',
    fontStyle: 'italic',
  },
  // Configuration screen styles
  configContainer: {
    flexGrow: 1,
    padding: 20,
    backgroundColor: '#f5f5f5',
  },
  configTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    textAlign: 'center',
    marginBottom: 30,
    color: '#333',
  },
  configSection: {
    marginBottom: 25,
    backgroundColor: '#fff',
    padding: 15,
    borderRadius: 10,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  configSectionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    marginBottom: 15,
    color: '#333',
  },
  configOptions: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 10,
  },
  configOption: {
    flex: 1,
    minWidth: 100,
    backgroundColor: '#f0f0f0',
    padding: 15,
    borderRadius: 8,
    alignItems: 'center',
    borderWidth: 2,
    borderColor: 'transparent',
  },
  configOptionActive: {
    backgroundColor: '#e6f3ff',
    borderColor: '#0066cc',
  },
  configOptionIcon: {
    fontSize: 24,
    marginBottom: 8,
  },
  configOptionText: {
    fontSize: 14,
    fontWeight: 'bold',
    textAlign: 'center',
    color: '#333',
  },
  wallSection: {
    marginBottom: 15,
  },
  wallTitle: {
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 10,
    color: '#555',
  },
  panelList: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  panelItem: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#e8f4fd',
    padding: 8,
    borderRadius: 15,
  },
  panelText: {
    fontSize: 12,
    color: '#0066cc',
    fontWeight: 'bold',
  },
  removeButton: {
    marginLeft: 5,
    backgroundColor: '#ff4444',
    borderRadius: 10,
    width: 20,
    height: 20,
    alignItems: 'center',
    justifyContent: 'center',
  },
  removeButtonText: {
    color: 'white',
    fontSize: 12,
    fontWeight: 'bold',
  },
  addButton: {
    backgroundColor: '#34C759',
    padding: 8,
    borderRadius: 15,
  },
  addButtonText: {
    color: 'white',
    fontSize: 12,
    fontWeight: 'bold',
  },
  startViewerButton: {
    backgroundColor: '#0066cc',
    padding: 20,
    borderRadius: 10,
    alignItems: 'center',
    marginTop: 20,
  },
  startViewerButtonText: {
    color: 'white',
    fontSize: 18,
    fontWeight: 'bold',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  configButton: {
    backgroundColor: '#666',
    padding: 10,
    borderRadius: 8,
    marginRight: 15,
  },
  configButtonText: {
    color: 'white',
    fontWeight: 'bold',
    fontSize: 14,
  },
});

export default MobileShowerViewer;