import React, { useState, useRef } from 'react';
import { Canvas, useFrame } from '@react-three/fiber';
import { OrbitControls, Text } from '@react-three/drei';
import * as THREE from 'three';

// Individual Panel Component
function Panel({ position, label, rotationAxis = 'y', panelIndex = 0, isSelected, onSelect, rotationAngle }) {
  const meshRef = useRef();

  useFrame(() => {
    if (meshRef.current) {
      // Apply rotation
      if (rotationAxis === 'y') {
        meshRef.current.rotation.y = rotationAngle;
      } else if (rotationAxis === 'z') {
        meshRef.current.rotation.z = rotationAngle;
      }
    }
  });

  // Handle panel selection
  const handleClick = () => {
    onSelect(label);
  };

  return (
    <mesh
      ref={meshRef}
      position={position}
      onClick={handleClick}
      onPointerDown={handleClick}
      castShadow
      receiveShadow
    >
      {/* Vertical rectangle panel */}
      <planeGeometry args={[1.5, 9]} />
      <meshStandardMaterial
        color={isSelected ? '#2ecc71' : (label.startsWith('C') ? '#3498db' : label.startsWith('R') ? '#e74c3c' : '#f39c12')}
        roughness={0.4}
        metalness={0.3}
        emissive={isSelected ? '#2ecc71' : '#000000'}
        emissiveIntensity={isSelected ? 0.3 : 0}
        side={THREE.DoubleSide}
      />
      {/* Label text on panel */}
      <Text position={[0, 0, 0.1]} fontSize={0.4} color="white">
        {label}
      </Text>
    </mesh>
  );
}

// Row of Panels Component
function PanelRow({ position, rowLabel, count = 3, rotationAxis = 'y', selectedPanel, onPanelSelect, panelRotations }) {
  const panelSpacing = 2.5; // Space between panels along x-axis

  return (
    <group position={position}>
      {Array.from({ length: count }).map((_, index) => {
        // All panels arranged horizontally along x-axis
        const panelPos = [(index - 1) * panelSpacing, 0, 0];
        const panelLabel = `${rowLabel}${index + 1}`;

        return (
          <Panel
            key={`${rowLabel}-${index}`}
            position={panelPos}
            label={panelLabel}
            rotationAxis={rotationAxis}
            panelIndex={index}
            isSelected={selectedPanel === panelLabel}
            onSelect={onPanelSelect}
            rotationAngle={panelRotations[panelLabel] || 0}
          />
        );
      })}
    </group>
  );
}

// Main App Component
export default function App() {
  const [selectedPanel, setSelectedPanel] = useState('C1');
  const [panelRotations, setPanelRotations] = useState({
    C1: 0, C2: 0, C3: 0,
    R1: 0, R2: 0, R3: 0,
    L1: 0, L2: 0, L3: 0
  });

  const handlePanelSelect = (panelLabel) => {
    setSelectedPanel(panelLabel);
  };

  const rotateSelectedPanel = (angle) => {
    setPanelRotations(prev => {
      const newRotation = (prev[selectedPanel] || 0) + angle;
      console.log(`Rotating ${selectedPanel}: ${prev[selectedPanel]} -> ${newRotation} (${Math.round(newRotation * 180 / Math.PI)}°)`);
      return {
        ...prev,
        [selectedPanel]: newRotation
      };
    });
  };

  const resetSelectedPanel = () => {
    setPanelRotations(prev => ({
      ...prev,
      [selectedPanel]: 0
    }));
  };

  const allPanels = ['C1', 'C2', 'C3', 'R1', 'R2', 'R3', 'L1', 'L2', 'L3'];

  return (
    <div style={{ width: '100%', height: '100vh' }}>
      <Canvas
        camera={{ position: [0, 0, 15], fov: 45 }}
        style={{ background: '#1a1a2e' }}
      >
        <ambientLight intensity={0.6} />
        <directionalLight
          position={[10, 10, 10]}
          intensity={0.8}
          castShadow
        />
        <pointLight position={[-10, 10, 5]} intensity={0.5} color="cyan" />

        {/* Center row (C1, C2, C3) along x-axis */}
        <PanelRow
          position={[0, 0, 0]}
          rowLabel="C"
          count={3}
          rotationAxis="y"
          selectedPanel={selectedPanel}
          onPanelSelect={handlePanelSelect}
          panelRotations={panelRotations}
        />

        {/* Right row (R1, R2, R3) */}
        <PanelRow
          position={[0, 4, 0]}
          rowLabel="R"
          count={3}
          rotationAxis="y"
          selectedPanel={selectedPanel}
          onPanelSelect={handlePanelSelect}
          panelRotations={panelRotations}
        />

        {/* Left row (L1, L2, L3) */}
        <PanelRow
          position={[0, -4, 0]}
          rowLabel="L"
          count={3}
          rotationAxis="y"
          selectedPanel={selectedPanel}
          onPanelSelect={handlePanelSelect}
          panelRotations={panelRotations}
        />

        <OrbitControls />
      </Canvas>

      {/* Instructions */}
      <div style={{
        position: 'absolute',
        top: '20px',
        left: '20px',
        color: 'white',
        backgroundColor: 'rgba(0,0,0,0.7)',
        padding: '15px',
        borderRadius: '8px',
        fontFamily: 'monospace',
        fontSize: '14px',
        maxWidth: '300px'
      }}>
        <h3 style={{ margin: '0 0 10px 0' }}>Controls:</h3>
        <p>• Click any panel to select it</p>
        <p>• Use buttons below to rotate selected panel</p>
        <p>• Drag to rotate camera view</p>
        <p>• Scroll to zoom in/out</p>
        <p style={{ marginTop: '10px', fontSize: '12px', opacity: 0.8 }}>
          C = Center row | R = Right row | L = Left row
        </p>
      </div>

      {/* Panel Selector and Rotation Controls */}
      <div style={{
        position: 'absolute',
        bottom: '20px',
        left: '50%',
        transform: 'translateX(-50%)',
        color: 'white',
        backgroundColor: 'rgba(0,0,0,0.8)',
        padding: '20px',
        borderRadius: '12px',
        fontFamily: 'monospace',
        fontSize: '14px',
        minWidth: '600px'
      }}>
        <h3 style={{ margin: '0 0 15px 0', textAlign: 'center' }}>
          Selected: <span style={{ color: '#2ecc71', fontSize: '18px' }}>{selectedPanel}</span>
        </h3>

        {/* Panel Selector Grid */}
        <div style={{ marginBottom: '15px' }}>
          <div style={{ fontSize: '12px', marginBottom: '8px', opacity: 0.7 }}>
            Select Panel:
          </div>
          <div style={{ display: 'flex', gap: '10px', justifyContent: 'center', flexWrap: 'wrap' }}>
            {allPanels.map(panel => (
              <button
                key={panel}
                onClick={() => setSelectedPanel(panel)}
                style={{
                  padding: '8px 16px',
                  backgroundColor: selectedPanel === panel ? '#2ecc71' : '#34495e',
                  color: 'white',
                  border: 'none',
                  borderRadius: '6px',
                  cursor: 'pointer',
                  fontFamily: 'monospace',
                  fontWeight: 'bold',
                  fontSize: '13px',
                  transition: 'all 0.2s'
                }}
                onMouseEnter={(e) => {
                  if (selectedPanel !== panel) e.target.style.backgroundColor = '#4a5f7f';
                }}
                onMouseLeave={(e) => {
                  if (selectedPanel !== panel) e.target.style.backgroundColor = '#34495e';
                }}
              >
                {panel}
              </button>
            ))}
          </div>
        </div>

        {/* Rotation Controls */}
        <div>
          <div style={{ fontSize: '12px', marginBottom: '8px', opacity: 0.7 }}>
            Rotate Selected Panel:
          </div>
          <div style={{ display: 'flex', gap: '10px', justifyContent: 'center' }}>
            <button
              onClick={() => rotateSelectedPanel(-Math.PI / 2)}
              style={{
                padding: '10px 20px',
                backgroundColor: '#e74c3c',
                color: 'white',
                border: 'none',
                borderRadius: '6px',
                cursor: 'pointer',
                fontFamily: 'monospace',
                fontWeight: 'bold',
                fontSize: '14px'
              }}
            >
              ← 90° CCW
            </button>
            <button
              onClick={() => rotateSelectedPanel(Math.PI / 2)}
              style={{
                padding: '10px 20px',
                backgroundColor: '#3498db',
                color: 'white',
                border: 'none',
                borderRadius: '6px',
                cursor: 'pointer',
                fontFamily: 'monospace',
                fontWeight: 'bold',
                fontSize: '14px'
              }}
            >
              90° CW →
            </button>
            <button
              onClick={resetSelectedPanel}
              style={{
                padding: '10px 20px',
                backgroundColor: '#95a5a6',
                color: 'white',
                border: 'none',
                borderRadius: '6px',
                cursor: 'pointer',
                fontFamily: 'monospace',
                fontWeight: 'bold',
                fontSize: '14px'
              }}
            >
              Reset
            </button>
          </div>
          <div style={{
            marginTop: '10px',
            textAlign: 'center',
            fontSize: '12px',
            opacity: 0.7
          }}>
            Current rotation: {Math.round((panelRotations[selectedPanel] || 0) * 180 / Math.PI)}°
          </div>
        </div>
      </div>
    </div>
  );
}