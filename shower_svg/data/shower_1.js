// Shower configuration 1: U-shaped with front wall split into two panels
import { PANEL_TYPES, createDefaultPanelShape } from '../utils/panelTypes';

export const shower_1 = [
  // Panel 11: Front wall left section
  {
    id: 'front1_11',
    panelGroup: 'front1',
    panelNumber: 11,
    width: 50,
    height: 100,
    x: -25,
    y: 0,
    z: 50,
    rotationY: 0,
    leftPanel: 'left_3',  // Panel to the left when viewing this panel
    rightPanel: 'front1_1',  // Panel to the right when viewing this panel
    shape: createDefaultPanelShape(PANEL_TYPES.NORMAL, 50, 100),
    connections: [
      { panelId: 'left_3', angle: 90, side: 'left' },
      { panelId: 'front1_1', angle: 180, side: 'right' },
      { panelId: 0, angle: 0, side: 'top' },
      { panelId: 0, angle: 0, side: 'bottom' }
    ]
  },
  // Panel 1: Front wall right section
  {
    id: 'front1_1',
    panelGroup: 'front1',
    panelNumber: 1,
    width: 50,
    height: 100,
    x: 25,
    y: 0,
    z: 50,
    rotationY: 0,
    leftPanel: 'front1_11',  // Panel to the left when viewing this panel
    rightPanel: 'right_2',  // Panel to the right when viewing this panel
    shape: createDefaultPanelShape(PANEL_TYPES.NORMAL, 50, 100),
    connections: [
      { panelId: 'front1_11', angle: 180, side: 'left' },
      { panelId: 'right_2', angle: 90, side: 'right' },
      { panelId: 0, angle: 0, side: 'top' },
      { panelId: 0, angle: 0, side: 'bottom' }
    ]
  },
  // Panel 2: Right wall
  {
    id: 'right_2',
    panelGroup: 'right',
    panelNumber: 2,
    width: 50,
    height: 100,
    x: 50,
    y: 0,
    z: 25,
    rotationY: 270,
    leftPanel: 'front1_1',  // Panel to the left when viewing this panel
    rightPanel: null,  // No panel to the right (open/outside)
    shape: createDefaultPanelShape(PANEL_TYPES.NORMAL, 50, 100),
    connections: [
      { panelId: 'front1_1', angle: 90, side: 'left' },
      { panelId: 0, angle: 0, side: 'right' },
      { panelId: 'left_3', angle: 90, side: 'back' },
      { panelId: 0, angle: 0, side: 'top' },
      { panelId: 0, angle: 0, side: 'bottom' }
    ]
  },
  // Panel 3: Left wall
  {
    id: 'left_3',
    panelGroup: 'left',
    panelNumber: 3,
    width: 50,
    height: 100,
    x: -50,
    y: 0,
    z: 25,
    rotationY: 90,
    leftPanel: null,  // No panel to the left (open/outside)
    rightPanel: 'front1_11',  // Panel to the right when viewing this panel
    shape: createDefaultPanelShape(PANEL_TYPES.NORMAL, 50, 100),
    connections: [
      { panelId: 'front1_11', angle: 90, side: 'right' },
      { panelId: 0, angle: 0, side: 'left' },
      { panelId: 'right_2', angle: 90, side: 'back' },
      { panelId: 0, angle: 0, side: 'top' },
      { panelId: 0, angle: 0, side: 'bottom' }
    ]
  },
];
