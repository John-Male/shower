/**
 * Groups panels based on their connections and angles
 *
 * Rules:
 * - Panels connected with a 180-degree angle are part of the same group
 * - Panels connected with non-180-degree angles (90, 135, etc.) are in separate groups
 * - A single panel on one side of a non-180-degree angle is considered its own group
 */

class UnionFind {
  constructor(size) {
    this.parent = Array.from({ length: size }, (_, i) => i);
    this.rank = Array(size).fill(0);
  }

  find(x) {
    if (this.parent[x] !== x) {
      this.parent[x] = this.find(this.parent[x]); // Path compression
    }
    return this.parent[x];
  }

  union(x, y) {
    const rootX = this.find(x);
    const rootY = this.find(y);

    if (rootX === rootY) return;

    // Union by rank
    if (this.rank[rootX] < this.rank[rootY]) {
      this.parent[rootX] = rootY;
    } else if (this.rank[rootX] > this.rank[rootY]) {
      this.parent[rootY] = rootX;
    } else {
      this.parent[rootY] = rootX;
      this.rank[rootX]++;
    }
  }
}

export const getPanelGroups = (panels) => {
  if (!panels || panels.length === 0) return [];

  // Create a map of panel id to index for quick lookup
  const panelIdToIndex = {};
  panels.forEach((panel, index) => {
    panelIdToIndex[panel.id] = index;
  });

  // Initialize union-find structure
  const uf = new UnionFind(panels.length);

  // Process connections
  panels.forEach((panel) => {
    if (!panel.connections) return;

    panel.connections.forEach((connection) => {
      // Only merge panels that are connected with a 180-degree angle
      if (connection.angle === 180) {
        const panelIndex = panelIdToIndex[panel.id];
        const connectedPanelIndex = panelIdToIndex[connection.panelId];

        if (connectedPanelIndex !== undefined) {
          uf.union(panelIndex, connectedPanelIndex);
        }
      }
    });
  });

  // Build groups based on the union-find structure
  const groupMap = {};
  panels.forEach((panel, index) => {
    const root = uf.find(index);
    if (!groupMap[root]) {
      groupMap[root] = [];
    }
    groupMap[root].push(panel.id);
  });

  // Convert to array of groups
  return Object.values(groupMap);
};

/**
 * Get detailed information about panel connections
 */
export const getPanelConnectionInfo = (panels) => {
  const connectionInfo = [];

  panels.forEach((panel) => {
    if (!panel.connections) return;

    panel.connections.forEach((connection) => {
      const connectedPanel = panels.find(p => p.id === connection.panelId);
      if (connectedPanel) {
        connectionInfo.push({
          fromPanel: panel.id,
          toPanel: connection.panelId,
          angle: connection.angle,
          side: connection.side,
          isGroupConnector: connection.angle === 180,
        });
      }
    });
  });

  return connectionInfo;
};

/**
 * Validates panel connections
 */
export const validatePanelConnections = (panels) => {
  const errors = [];

  panels.forEach((panel) => {
    if (!panel.connections) return;

    panel.connections.forEach((connection) => {
      // Check if connected panel exists (panelId 0 means no panel, which is valid)
      if (connection.panelId !== 0) {
        const connectedPanel = panels.find(p => p.id === connection.panelId);
        if (!connectedPanel) {
          errors.push({
            panelId: panel.id,
            error: `Connected panel ${connection.panelId} does not exist`,
          });
        }
      }

      // Check if angle is valid (0, 90, 135, or 180)
      if (![0, 90, 135, 180].includes(connection.angle)) {
        errors.push({
          panelId: panel.id,
          error: `Invalid angle ${connection.angle}. Must be 0, 90, 135, or 180`,
        });
      }
    });
  });

  return errors;
};
