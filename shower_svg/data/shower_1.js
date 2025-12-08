// Shower configuration 1: U-shaped with front wall split into two panels
export const shower_1 = [
  // Panel 11: Front wall left section
  {
    id: 11,
    width: 50,
    height: 100,
    x: -25,
    y: 0,
    z: 50,
    rotationY: 0,
    connections: [
      { panelId: 3, angle: 90, side: 'left' },
      { panelId: 1, angle: 180, side: 'right' },
      { panelId: 0, angle: 0, side: 'top' },
      { panelId: 0, angle: 0, side: 'bottom' }
    ]
  },
  // Panel 1: Front wall right section
  {
    id: 1,
    width: 50,
    height: 100,
    x: 25,
    y: 0,
    z: 50,
    rotationY: 0,
    connections: [
      { panelId: 11, angle: 180, side: 'left' },
      { panelId: 2, angle: 90, side: 'right' },
      { panelId: 0, angle: 0, side: 'top' },
      { panelId: 0, angle: 0, side: 'bottom' }
    ]
  },
  // Panel 2: Right wall
  {
    id: 2,
    width: 50,
    height: 100,
    x: 50,
    y: 0,
    z: 25,
    rotationY: 270,
    connections: [
      { panelId: 1, angle: 90, side: 'left' },
      { panelId: 0, angle: 0, side: 'right' },
      { panelId: 3, angle: 90, side: 'back' },
      { panelId: 0, angle: 0, side: 'top' },
      { panelId: 0, angle: 0, side: 'bottom' }
    ]
  },
  // Panel 3: Left wall
  {
    id: 3,
    width: 50,
    height: 100,
    x: -50,
    y: 0,
    z: 25,
    rotationY: 90,
    connections: [
      { panelId: 11, angle: 90, side: 'right' },
      { panelId: 0, angle: 0, side: 'left' },
      { panelId: 2, angle: 90, side: 'back' },
      { panelId: 0, angle: 0, side: 'top' },
      { panelId: 0, angle: 0, side: 'bottom' }
    ]
  },
];
