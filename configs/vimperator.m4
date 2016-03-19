CONFIG_FILE(vimperator, ~/.vimperatorrc)
" general config
set toolbars=nonavigation
map <Leader>h :noh<CR>
map <Leader>t :set toolbars=invnavigation<CR>

js <<EOJS
    mappings.addUserMap(modes.NORMAL, ['gw'], "move tab to new window",
        function(){
            gBrowser.replaceTabWithWindow(gBrowser.selectedTab);
        }, {});
EOJS

"tree-style-tabs mappings
"should be a plugin really.

js <<EOJS
    var addTabChangeMap = function(command, description, f) {
        mappings.addUserMap(modes.NORMAL, [command], description,
            function(count){
                if (count === null) count = 1;

                // apply f count times to selectedTab, stopping if it returns null.
                var tab = gBrowser.selectedTab;
                for (var i = 0; i < count; i++) {
                    var newTab = f(tab);
                    if (newTab === null) break;
                    tab = newTab;
                }
                gBrowser.selectedTab = tab;
            },
            {count: true});
    };
    addTabChangeMap("gp", "go to parent tab",
            TreeStyleTabService.getParentTab.bind(TreeStyleTabService));
    addTabChangeMap("gr", "go to root tab",
            TreeStyleTabService.getRootTab.bind(TreeStyleTabService));
    addTabChangeMap("gs", "go to next sibling tab",
            TreeStyleTabService.getNextSiblingTab.bind(TreeStyleTabService));
    addTabChangeMap("gS", "go to previous sibling tab",
            TreeStyleTabService.getPreviousSiblingTab.bind(TreeStyleTabService));
    addTabChangeMap("gc", "go to first child tab",
            TreeStyleTabService.getFirstChildTab.bind(TreeStyleTabService));
    addTabChangeMap("gC", "go to last child tab",
            TreeStyleTabService.getLastChildTab.bind(TreeStyleTabService));

    mappings.addUserMap(modes.NORMAL, ['gd'], "delete current tab and all children",
        function(){
            var tabs = TreeStyleTabService.getDescendantTabs(gBrowser.selectedTab);
            tabs.push(gBrowser.selectedTab);
            tabs.forEach(gBrowser.removeTab.bind(gBrowser));
        }, {});

    mappings.addUserMap(modes.NORMAL, ['gz'], "delete all children",
        function(){
            var tabs = TreeStyleTabService.getDescendantTabs(gBrowser.selectedTab);
            tabs.forEach(gBrowser.removeTab.bind(gBrowser));
        }, {});

    mappings.addUserMap(modes.NORMAL, ['gD'], "delete current tree and all children",
        function(){
            var root = TreeStyleTabService.getRootTab(gBrowser.selectedTab);
            var tabs = TreeStyleTabService.getDescendantTabs(root);
            tabs.push(root);
            tabs.forEach(gBrowser.removeTab.bind(gBrowser));
        }, {});

    mappings.addUserMap(modes.NORMAL, ['gZ'], "delete all children of current root",
        function(){
            var root = TreeStyleTabService.getRootTab(gBrowser.selectedTab);
            var tabs = TreeStyleTabService.getDescendantTabs(root);
            tabs.forEach(gBrowser.removeTab.bind(gBrowser));
        }, {});

    mappings.addUserMap(modes.NORMAL, ['go'], "open next tab in new tree",
    function(){
        var stop = function(event) {
            TreeStyleTabService.stopToOpenChildTab(gBrowser);
            liberator.echomsg("current group");
            gBrowser.tabContainer.removeEventListener("TabOpen", stop, false);
        };

        if (TreeStyleTabService.checkToOpenChildTab(gBrowser)) {
            stop();
        } else {
            TreeStyleTabService.readyToOpenNewTabGroup(gBrowser);
            liberator.echomsg("new group");
            gBrowser.tabContainer.addEventListener("TabOpen", stop, false);
        }
        TreeStyleTabService.readyToOpenNewTabGroup(gBrowser);
        setTimeout(stop, 1500);
    }, {});

    mappings.addUserMap(modes.NORMAL, ['gO'], "open new tabs in new tree",
    function(){
        var stop = function(event) {
            TreeStyleTabService.stopToOpenChildTab(gBrowser);
            liberator.echomsg("current group");
            gBrowser.tabContainer.removeEventListener("TabSelect", stop, false);
        };

        if (TreeStyleTabService.checkToOpenChildTab(gBrowser)) {
            stop();
        } else {
            TreeStyleTabService.readyToOpenNewTabGroup(gBrowser);
            liberator.echomsg("new group");
            gBrowser.tabContainer.addEventListener("TabSelect", stop, false);
        }
    }, {});
EOJS

