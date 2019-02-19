<%@ Page Language="VB" AutoEventWireup="true" CodeFile="vb_Features.aspx.vb" Inherits="SiteMap_vb_Features" %>

<%@ Register tagprefix="obout" assembly="Obout.Ajax.UI" namespace="Obout.Ajax.UI.SiteMap" %>
<%@ Register tagprefix="obout" assembly="obout_Interface" namespace="Obout.Interface" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Example Page - Obout.Ajax.UI.SiteMap - Features</title>
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
    <form id="form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
        <br />
		<a class="examples" href="Default.aspx?type=VBNET">« Back to examples</a>
        <br /><br />
        <span style="font-size:16px"><b>Obout.Ajax.UI.SiteMap</b> - Features</span>
        <br /><br />
        <asp:SiteMapDataSource ID="SiteMapDataSource1" ShowStartingNode="false" runat="server" />
        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
		        <obout:OboutCheckBox runat="server" ID="EnableLeavesOnly" Checked="true" FolderStyle="~/Interface/styles/premiere_blue/OboutCheckBox" Text="<span class='chkBox'>Enable leaves only</span>" AutoPostBack="true" />
                <br />
		        <obout:OboutCheckBox runat="server" ID="EnableNodeSelection" Checked="true" FolderStyle="~/Interface/styles/premiere_blue/OboutCheckBox" Text="<span class='chkBox'>Enable node selection</span>" AutoPostBack="true" />
                <br />
		        <obout:OboutCheckBox runat="server" ID="EnableServerSide" Checked="true" FolderStyle="~/Interface/styles/premiere_blue/OboutCheckBox" Text="<span class='chkBox'>Enable server-side action when node selected</span>" AutoPostBack="true" />
                <br />
                <table border="0" cellpadding="0" cellspacing="3">
                    <tr>
		                <td>Number of columns:</td>
                        <td>
                            <obout:OboutTextBox runat="server" ID="Columns" Width="30" Text="3" FolderStyle="~/Interface/styles/premiere_blue/OboutTextBox" AutoPostBack="true" /> 
		                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Columns" ErrorMessage="Please enter a number" Display="Dynamic" CssClass="validator" />
                            <asp:CompareValidator ID="ComparedValidator1" runat="server" Operator="DataTypeCheck" Type="Integer" ControlToValidate="Columns" ErrorMessage="Value must be a number" Display="Dynamic" CssClass="validator" />
                        </td>
                    </tr>
                    <tr>
		                <td>Maximum number of levels:</td>
                        <td>
		                    <obout:OboutTextBox runat="server" ID="MaximumDepth" Width="30" Text="2" FolderStyle="~/Interface/styles/premiere_blue/OboutTextBox" AutoPostBack="true" /> 
		                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="MaximumDepth" ErrorMessage="Please enter a number" Display="Dynamic" CssClass="validator" />
                            <asp:CompareValidator ID="ComparedValidator2" runat="server" Operator="DataTypeCheck" Type="Integer" ControlToValidate="MaximumDepth" ErrorMessage="Value must be a number" Display="Dynamic" CssClass="validator" />
                        </td>
                    </tr>
		        </table>
                <br />
                <obout:SiteMap ID="SiteMap1" DataSourceID="SiteMapDataSource1" runat="server" Columns="3" MaximumDepth="2" >
                    <TreePrototype runat="server">
                        <RootNodeStyle NodeCSS="msn_root_node" />
                        <NodeStyle NodeCSS="msn_folder_node" />
                        <LeafNodeStyle NodeCSS="msn_leaf_node" />
                    </TreePrototype>
                    <MainTable CellPadding="0" CellSpacing="0" />
                </obout:SiteMap>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
