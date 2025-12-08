import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View, Platform } from 'react-native';
import React, { useState } from 'react';
import MobileShowerViewer from './MobileShowerViewer.jsx';
import TestApp from './TestApp.jsx';

// Import 3D viewers only on web platform
let ShowerViewer = null;
// RotatingPanels disabled due to Metro bundler ESM compatibility issues
// let RotatingPanels = null;
if (Platform.OS === 'web') {
  try {
    ShowerViewer = require('./ShowerViewer_1.jsx').default;
  } catch (error) {
    console.log('ShowerViewer not available:', error);
  }
  // try {
  //   RotatingPanels = require('./RotatingPanels.jsx').default;
  // } catch (error) {
  //   console.log('RotatingPanels not available:', error);
  // }
}

export default function App() {
  const [currentView, setCurrentView] = useState('landing'); // 'landing', 'showerViewer', 'rotatingPanels', 'mobileShower'

  // Show ShowerViewer on web
  if (Platform.OS === 'web' && ShowerViewer && currentView === 'showerViewer') {
    return <ShowerViewer />;
  }

  // RotatingPanels disabled - ESM compatibility issues with Metro bundler
  // if (Platform.OS === 'web' && RotatingPanels && currentView === 'rotatingPanels') {
  //   return <RotatingPanels />;
  // }

  // Show MobileShowerViewer
  if (currentView === 'mobileShower') {
    return <MobileShowerViewer />;
  }

  // Landing page (both mobile and web)
  return (
    <View style={styles.container}>
      <Text style={styles.title}>Shower App</Text>
      <Text style={styles.subtitle}>Choose a viewer:</Text>

      {/* Mobile Shower Viewer - available on all platforms */}
      <Text
        style={styles.link}
        onPress={() => setCurrentView('mobileShower')}
      >
        🚿 Mobile Shower Viewer
      </Text>

      {/* Rotating Panels - disabled due to ESM compatibility */}
      {/* {Platform.OS === 'web' && RotatingPanels && (
        <Text
          style={styles.link}
          onPress={() => setCurrentView('rotatingPanels')}
        >
          🔄 Rotating Panels (3D)
        </Text>
      )} */}

      {/* Original Shower Viewer - web only */}
      {Platform.OS === 'web' && ShowerViewer && (
        <Text
          style={styles.link}
          onPress={() => setCurrentView('showerViewer')}
        >
          📱 Shower 3D Viewer (Original)
        </Text>
      )}

      {/* Debug info */}
      {Platform.OS === 'web' && (
        <Text style={styles.mobileNote}>
          Debug: Platform={Platform.OS}, ShowerViewer={ShowerViewer ? 'loaded' : 'null'}
        </Text>
      )}

      {Platform.OS !== 'web' && (
        <Text style={styles.mobileNote}>
          Note: 3D viewers are only available on web. Use the Mobile Shower Viewer on mobile devices.
        </Text>
      )}

      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 10,
  },
  subtitle: {
    fontSize: 16,
    marginBottom: 10,
    color: '#333',
  },
  description: {
    fontSize: 14,
    marginBottom: 15,
    color: '#666',
  },
  link: {
    fontSize: 18,
    color: '#0066cc',
    marginTop: 10,
    padding: 10,
    textDecorationLine: 'underline',
    cursor: Platform.OS === 'web' ? 'pointer' : 'default',
  },
  mobileNote: {
    fontSize: 14,
    color: '#666',
    marginTop: 20,
    textAlign: 'center',
  },
});
