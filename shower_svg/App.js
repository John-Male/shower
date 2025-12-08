import { StatusBar } from 'expo-status-bar';
import { StyleSheet, View, ScrollView, Text, TouchableOpacity } from 'react-native';
import PanelCanvas from './components/PanelCanvas';
import PanelControls from './components/PanelControls';
import { useState, useMemo } from 'react';
import { shower_1 } from './data/shower_1';
import { getRotatedShowerForPanel } from './utils/showerRotation';

export default function App() {
  const [baseShower, setBaseShower] = useState(shower_1);
  const [currentPanelId, setCurrentPanelId] = useState('front1_1');
  const [showControls, setShowControls] = useState(false);

  // Calculate rotated shower configuration based on current panel
  const panels = useMemo(
    () => getRotatedShowerForPanel(baseShower, currentPanelId, baseShower),
    [baseShower, currentPanelId]
  );

  const currentPanel = panels.find(p => p.id === currentPanelId);

  const navigateLeft = () => {
    // Navigate to the panel on the user's LEFT (from their viewing perspective)
    // First try using the rightPanel property (easier), fallback to connections
    if (currentPanel?.rightPanel) {
      setCurrentPanelId(currentPanel.rightPanel);
    } else {
      const rightConnection = currentPanel?.connections.find(c => c.side === 'right' && c.panelId !== 0);
      if (rightConnection) {
        setCurrentPanelId(rightConnection.panelId);
      }
    }
  };

  const navigateRight = () => {
    // Navigate to the panel on the user's RIGHT (from their viewing perspective)
    // First try using the leftPanel property (easier), fallback to connections
    if (currentPanel?.leftPanel) {
      setCurrentPanelId(currentPanel.leftPanel);
    } else {
      const leftConnection = currentPanel?.connections.find(c => c.side === 'left' && c.panelId !== 0);
      if (leftConnection) {
        setCurrentPanelId(leftConnection.panelId);
      }
    }
  };

  return (
    <View style={styles.container}>
      <View style={styles.header}>
        <View style={styles.headerTop}>
          <View>
            <Text style={styles.title}>{currentPanelId}</Text>
            {currentPanel?.panelGroup && (
              <Text style={styles.subtitle}>Group: {currentPanel.panelGroup}</Text>
            )}
          </View>
          <TouchableOpacity
            style={styles.button}
            onPress={() => setShowControls(!showControls)}
          >
            <Text style={styles.buttonText}>
              {showControls ? 'Hide' : 'Show'} Controls
            </Text>
          </TouchableOpacity>
        </View>
        <View style={styles.navButtons}>
          <TouchableOpacity
            style={[styles.button, styles.navButton]}
            onPress={navigateLeft}
          >
            <Text style={styles.buttonText}>← Left</Text>
          </TouchableOpacity>
          <TouchableOpacity
            style={[styles.button, styles.navButton]}
            onPress={navigateRight}
          >
            <Text style={styles.buttonText}>Right →</Text>
          </TouchableOpacity>
        </View>
      </View>

      {showControls ? (
        <PanelControls panels={baseShower} onPanelsChange={setBaseShower} />
      ) : (
        <ScrollView style={styles.scrollView} horizontal={true}>
          <ScrollView style={styles.scrollView}>
            <PanelCanvas panels={panels} currentPanelId={currentPanelId} />
          </ScrollView>
        </ScrollView>
      )}

      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    padding: 20,
    paddingTop: 60,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',
    flexDirection: 'column',
  },
  headerTop: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  title: {
    fontSize: 20,
    fontWeight: 'bold',
  },
  subtitle: {
    fontSize: 14,
    color: '#666',
    marginTop: 2,
  },
  navButtons: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 10,
  },
  navButton: {
    minWidth: 80,
    marginHorizontal: 5,
  },
  button: {
    backgroundColor: '#007AFF',
    padding: 10,
    borderRadius: 8,
  },
  buttonText: {
    color: '#fff',
    fontWeight: '600',
  },
  scrollView: {
    flex: 1,
  },
});
