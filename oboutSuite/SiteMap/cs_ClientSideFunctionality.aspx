<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cs_ClientSideFunctionality.aspx.cs" Inherits="SiteMap_cs_ClientSideFunctionality" %>

<%@ Register tagprefix="obout" assembly="Obout.Ajax.UI" namespace="Obout.Ajax.UI.SiteMap" %>
<%@ Register tagprefix="obout" assembly="obout_Interface" namespace="Obout.Interface" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Example Page - Obout.Ajax.UI.SiteMap - Client-side Functionality</title>
    <style type="text/css">
        /* Text style in the page */
        body, .chkBox
        {
            font-family: "Segoe UI" ,Arial,sans-serif;
            font-size: 12px;
        }
        /* Style for ASP.NET validators */
		.validator
		{
			font:11px Verdana;
		}
        /* Root node */
        .msn_root_node
        {
            font-family: Verdana;
            font-size: 8pt;
            font-weight: bold;
            color: #0A24FF;
            background-color: #E0E0E0;
        }
        /* Not root node with children */
        .msn_folder_node
        {
            color: #0A24FF;
        }
        /* Leaf node */
        .msn_leaf_node
        {
            color: black;
        }
    </style>
</head>
<body>
    <script type="text/javascript">
        // on 'EnableLeavesOnly' checked change
        function ccEnableLeavesOnly(sender, isChecked) {
            // get the SiteMap component
            var siteMap = $find("<%= SiteMap1.ClientID %>");
            // get all its inner Tree components
            var treeComponents = siteMap.get_innerTreeComponents();
            // go throw the tree components
            for (var i = 0; i < treeComponents.length; i++) {
                // current Tree component
                var tree = treeComponents[i];
                // set its property
                tree.set_enableLeavesOnly(isChecked);
                // enable leaves only?
                if (isChecked) {
                    // get selected nodes
                    var selectedNodes = tree.getSelectedNodes();
                    //go through selected nodes (it may be one only)
                    for (var j = 0; j < selectedNodes.length; j++) {
                        var selectedNode = selectedNodes[j];
                        // not a leaf node?
                        if (tree.hasChildNode(selectedNode)) {
                            // uselect it
                            tree.unselectNode(selectedNode);
                        }
                    }
                }
            }
        }

        // on 'EnableNodeSelection' checked cahange
        function ccEnableNodeSelection(sender, isChecked) {
            // get the SiteMap component
            var siteMap = $find("<%= SiteMap1.ClientID %>");
            // get all its inner Tree components
            var treeComponents = siteMap.get_innerTreeComponents();
            // go throw the tree components
            for (var i = 0; i < treeComponents.length; i++) {
                // current Tree component
                var tree = treeComponents[i];
                // set its property
                tree.set_enableNodeSelection(isChecked);
                // to disable?
                if (!isChecked) {
                    // clear selection if any node selected
                    tree.clearSelection();
                }
            }
        }

        //-------------------------------
        // Expand/collapse the whole Tree
        //-------------------------------
        function new_tall(obTree, expand) {
            // get the first root node
            var rootTop = obTree.getNodeByIndex("0");
            // go throw all root nodes
            while (rootTop != null) {
                // expand/collapse the node
                node_expand_collapse(obTree, rootTop, expand);
                // Get the next sibling node
                rootTop = obTree.getNextSiblingNode(rootTop);
            }
        }
        // expand/collapse the node
        function node_expand_collapse(obTree, node, expand) {
            if (expand) {
                // expand the node if collapsed
                if (!obTree.isExpanded(node)) obTree.expand(node);
            } else {
                // collapse the node if expanded
                if (obTree.isExpanded(node)) obTree.collapse(node);
            }
            // child nodes?
            if (obTree.hasChildNode(node)) {
                // get them
                var childNodes = obTree.getChildNodes(node);
                // go throw all child nodes
                for (var i = 0; i < childNodes.length; i++) {
                    // expand/collapse the child node
                    node_expand_collapse(obTree, childNodes[i], expand);
                }
            }
        }

        // trigger (whether expanded on init)
        var expand = <%= SiteMap1.ExpandSubTrees.ToString().ToLower() %>;
        // handler for the "Expand/collapse" button
        function expandCollapse() {
            // trigger
            expand = !expand;
            // get the SiteMap component
            var siteMap = $find("<%= SiteMap1.ClientID %>");
            // get all its inner Tree components
            var treeComponents = siteMap.get_innerTreeComponents();
            // go throw the tree components
            for (var i = 0; i < treeComponents.length; i++) {
                // current Tree component
                var tree = treeComponents[i];
                // expand/collapse all nodes
                new_tall(tree, expand);
            }
            return false;
        }
    </script>
    <form id="form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
        <br />
		<a class="examples" href="Default.aspx?type=CSHARP">« Back to examples</a>
        <br /><br />
        <span style="font-size:16px"><b>Obout.Ajax.UI.SiteMap</b> - Client-side Functionality</span>
        <br /><br />
        <asp:SiteMapDataSource ID="SiteMapDataSource1" ShowStartingNode="false" runat="server" />
		<obout:OboutCheckBox runat="server" ID="EnableLeavesOnly" Checked="true" FolderStyle="~/Interface/styles/premiere_blue/OboutCheckBox" Text="<span class='chkBox'>Enable leaves only</span>" >
             <ClientSideEvents OnCheckedChanged="ccEnableLeavesOnly" />
        </obout:OboutCheckBox>
        <br />
		<obout:OboutCheckBox runat="server" ID="EnableNodeSelection" Checked="true" FolderStyle="~/Interface/styles/premiere_blue/OboutCheckBox" Text="<span class='chkBox'>Enable node selection</span>" >
             <ClientSideEvents OnCheckedChanged="ccEnableNodeSelection" />
        </obout:OboutCheckBox>
        <br />
        <br />
        <obout:OboutButton runat="server" Text="Collapse/Expand the Site Map" OnClientClick="return expandCollapse();" FolderStyle="~/Interface/styles/premiere_blue/OboutButton" />
        <br />
        <br />
        <obout:SiteMap ID="SiteMap1" DataSourceID="SiteMapDataSource1" runat="server" Columns="3" MaximumDepth="2" ExpandSubTrees="false">
            <TreePrototype runat="server" EnableLeavesOnly="true" EnableNodeSelection="true">
                <RootNodeStyle NodeCSS="msn_root_node" />
                <NodeStyle NodeCSS="msn_folder_node" />
                <LeafNodeStyle NodeCSS="msn_leaf_node" />
            </TreePrototype>
            <MainTable CellPadding="0" CellSpacing="0" />
        </obout:SiteMap>
    </form>
</body>
</html>
