# Panel Configuration System

An Expo React Native app for visualizing and configuring rectangular panels connected at various angles.

## Features

- **SVG-based rendering** of tall rectangular panels (taller than they are wide)
- **Panel connections** at configurable angles (0°, 90°, 135°, or 180°)
- **Perspective rendering**:
  - Panels with rotation=0 at 90° angles display as edge-on (thin line)
  - Panels with rotation > 0 display rotated for 3D perspective effect
- **Automatic panel grouping**:
  - Panels connected at 180° angles are grouped together
  - Panels at non-180° angles form separate groups
  - 0° angle indicates no panel on that side (open edge)
- **Aligned panel heights** for non-180° connections
- **Interactive controls** to add, edit, and connect panels
- **Visual representation** with color-coded panel groups

## Installation

```bash
npm install
```

## Running the App

### Web
```bash
npm run web
```

### iOS
```bash
npm run ios
```

### Android
```bash
npm run android
```

## Usage

### Viewing Panels
- The main screen shows all panels rendered in SVG
- Each panel is labeled with its ID
- Connection angles are displayed next to each panel
- Panel groups are shown below the canvas with color indicators

### Editing Panels
1. Tap "Show Controls" to access the panel editor
2. Select a panel from the list to edit it
3. Modify dimensions (width, height) and position (x, y)
4. Add connections to other panels by specifying:
   - Target panel ID (use 0 for no panel/open edge)
   - Connection angle (0°, 90°, 135°, or 180°)
   - Connection side (top, right, bottom, left)

### Panel Grouping Rules

- **180° connections**: Panels connected at 180° are part of the same group (straight wall)
- **90° connections**: Creates an L-shaped configuration with separate groups
- **135° connections**: Creates angled configurations with separate groups
- **0° connections**: Indicates no panel on that side (open edge)
- **Height alignment**: All panels at non-180° angles are aligned at the same height

## Example Configurations

The app comes with four example configurations:

1. **L-shaped** (Panels 1-2): Two panels at 90° angle
2. **Straight wall** (Panels 3-5): Three panels connected at 180° angles (one group)
3. **Angled wall** (Panels 6-7): Two panels at 135° angle
4. **Perspective view** (Panels 8-9): 90° angle with panel 8 shown edge-on (as a line) and panel 9 rotated slightly

## Data Structure

Each panel has the following structure:

```javascript
{
  id: number,              // Unique identifier
  width: number,           // Panel width (should be less than height)
  height: number,          // Panel height (should be greater than width)
  x: number,               // X position on canvas
  y: number,               // Y position on canvas
  rotation: number,        // Optional: Rotation angle in degrees (0 = edge-on view for 90° angles)
  connections: [           // Array of connections to other panels
    {
      panelId: number,     // ID of connected panel (0 = no panel/open edge)
      angle: number,       // Connection angle (0, 90, 135, or 180)
      side: string         // Connection side ('top', 'right', 'bottom', 'left')
    }
  ]
}
```

## Architecture

- **App.js**: Main application component
- **components/PanelCanvas.js**: SVG rendering and visualization
- **components/PanelControls.js**: Interactive panel editor
- **utils/panelGrouping.js**: Panel grouping algorithm using Union-Find

## Technologies

- Expo SDK 54
- React Native
- react-native-svg
