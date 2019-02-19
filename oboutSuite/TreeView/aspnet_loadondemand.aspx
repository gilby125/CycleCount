<%@ Page Language="C#" %>

<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Example Page - LoadOnDemand Support</title>

    <script language="C#" runat="server">
        void Page_load(object sender, EventArgs e)
        {
            if (IsPostBack)
                ObClassicTree.DataBind();
        }	
    </script>

     <style type="text/css">
        body
        {
            font-family: "Segoe UI" ,Arial,sans-serif;
            font-size: 12px;
        }
    </style>


</head>
<body>
    <form id="form1" runat="server">
    <br />
		<a class="examples" href="Default.aspx?type=ASPNET">« Back to examples</a>
		<br />
    <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />

    <script type="text/javascript">
        function onCheckChange(obj) {
            $find("<%=ObClassicTree.ClientID %>").loadingMessage = obj.checked ? 'Refreshing...' : 'Loading...';
        }
        // on node select
        function clientNodeSelect(sender, args) {
            // save index of the current node to the cookie
            var index = sender.getNodeIndex(args.node);
            // Set expiration days here
            var expiredays = 3;
            var ExpireDate = new Date();
            ExpireDate.setTime(ExpireDate.getTime() + (expiredays * 24 * 3600 * 1000));
            // set the cookies
            setCookie(index, ExpireDate, "", "", "", getCookieName());
        }

        // set cookies
        function setCookie(value, expires, path, domain, secure, cookieName) {
            var curCookie = cookieName + "=" + value +
	                          ((expires) ? "; expires=" + expires.toGMTString() : "") +
	                          ((path) ? "; path=" + path : "") +
	                          ((domain) ? "; domain=" + domain : "") +
	                          ((secure) ? "; secure" : "");
            document.cookie = curCookie;
        }

        var globalSelectedIndex = null;
        // on node expand
        function onAfterNodeExpand(sender, args) {
            if (globalSelectedIndex != null) {
                // try to select again
                selectNode(sender, globalSelectedIndex);
            }
        }
        // try to select the node by index
        function selectNode(tree, selectedIndex) {
            var node = tree.getNodeByIndex(selectedIndex);
            if (node != null) {
                if (tree.getNodeIndex(node) != selectedIndex) { // the node is not loaded yet
                    globalSelectedIndex = selectedIndex;
                    tree.expand(node);
                    return;
                }
                globalSelectedIndex = null;
                // select it
                tree.setSelected(node);
                // expand its parents
                var parent = tree.getParentNode(node);
                while (parent != null) {
                    if (!tree.isExpanded(parent)) { // if not expanded yet
                        tree.expand(parent);
                    }
                    parent = tree.getParentNode(parent);
                }
            }
        }

        // on page load
        function pageLoad(sender, args) {
            var selectedIndex = null;
            // if cookie exists
            if (document.cookie != null) {
                // go through all cookies
                var ck = document.cookie.split(";");
                for (var i = 0; i < ck.length; i++) {
                    // split pair: name and value
                    var tmpArr = ck[i].split("=");
                    // test on our cookie name
                    if (tmpArr[0].indexOf(getCookieName()) != -1) {
                        selectedIndex = tmpArr[1];
                        break;
                    }
                }
            }
            // index of previously selected node was saved
            if (selectedIndex != null) {
                // get the Tree component
                var tree = findTree();
                if (tree != null) {
                    // try to select the node
                    selectNode(tree, selectedIndex);
                }
            }
        }
        // find the tree component
        function findTree() {
            var components = Sys.Application.getComponents();
            for (var i = 0; i < components.length; i++) {
                var component = components[i];
                var type = Object.getType(component).getName();
                if (type == "Obout.Ajax.UI.TreeView.Tree") {
                    return component;
                }
            }
            return null;
        }
        // get path loacation
        function getPathLocation() {
            return window.location.pathname;
        }
        // get cookie's name
        function getCookieName() {
            return getPathLocation() + "_selectedIndex";
        }
    </script>

    <div>
        <h2>
            ASP.NET TreeView - LoadOnDemand Support</h2>
        <div class="live_example">
        </div>
        <asp:XmlDataSource ID="XmlDataSource1" DataFile="employee.xml" runat="server"></asp:XmlDataSource>
        <p>
            To enable 'LoadOndemand' feature for a node, the node property, '<b>ExpandMode</b>'
            should be set as '<b>ServerSideCallback</b>'</p>
        <table>
            <tr>
                <td>
                    <obout:Tree ID="ObClassicTree" DataSourceID="XmlDataSource1" EnableViewState="false" OnNodeSelect="clientNodeSelect" OnAfterNodeExpand="onAfterNodeExpand"
                        LoadingMessage="Loading..." CssClass="vista" runat="server" Width="200px">
                        <DataBindings>
                            <obout:NodeBinding DataMember="employee" ExpandMode="ServerSideCallback" TextField="name"
                                ImageUrl="img/engineer-icon.png" />
                        </DataBindings>
                    </obout:Tree>
                </td>
                <td valign="top">
                    <input id="Checkbox1" onchange="onCheckChange(this)" type="checkbox" />
                    Change loading message as 'Refreshing'
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
