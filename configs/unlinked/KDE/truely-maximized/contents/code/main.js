// utils
function isMaximized(client) {
    const area = workspace.clientArea(KWin.MaximizeArea, client);
    return client.width >= area.width && client.height >= area.height;
}

// management code
let blacklist = []; // initialized in init()
let managed = [];

function tryManage(client) {
    if (blacklist.includes(client.resourceClass.toString())) {
        return;
    }
    if (client.noBorder) {
        return; // If the border is already disabled, something else is managing it. We don't want to step on that.
    }
    managed.push(client.frameId);
}
function isManaged(client) {
    return managed.includes(client.frameId);
}

// listeners
function clientAdded(client) {
    tryManage(client);

    client.old_opacity = client.opacity;
    if (isManaged(client) && isMaximized(client)) {
        client.noBorder = true;
        client.opacity = 1.0;
    } else if (isManaged(client)) {
        client.opacity = client.old_opacity;
    }
}
workspace.clientAdded.connect(clientAdded);

workspace.clientRemoved.connect(client => {
    if (isManaged(client)) {
        managed.splice(managed.indexOf(client.frameId), 1);
    }
});

workspace.clientMaximizeSet.connect(
    (client, horizontalMaximized, verticalMaximized) => {
        if (isManaged(client)) {
            client.noBorder = isMaximized(client);
        }
        client.opacity =
            horizontalMaximized && verticalMaximized ? 1.0 : client.old_opacity;
    }
);

// screen edge listener
function screenEdgeActivated() {
    for (client of workspace.clientList()) {
        if (client.active) {
            if (isManaged(client)) {
                if (isMaximized(client)) {
                    client.noBorder = !client.noBorder;
                }
                client.opacity = isMaximized(client) ? 1.0 : client.old_opacity;
            }
            return;
        }
    }
}

// magic code to register a screen edge listener that the user can then configure in screen edges settings
// it's just done this way, there isn't really an explanation in the docs
let registeredBorders = [];
function initScreenEdges() {
    for (var i in registeredBorders) {
        unregisterScreenEdge(registeredBorders[i]);
    }
    registeredBorders = [];
    let borders = readConfig("BorderActivate", "").toString().split(",");
    for (var i in borders) {
        let border = parseInt(borders[i]);
        if (isFinite(border)) {
            registeredBorders.push(border);
            registerScreenEdge(border, screenEdgeActivated);
        }
    }
}

// init
function init() {
    blacklist = readConfig("blacklist", "yakuake")
        .split(",")
        .filter(name => name.length != 0);
    initScreenEdges();
}
options.configChanged.connect(init);
init();

for (client of workspace.clientList()) {
    clientAdded(client);
}
