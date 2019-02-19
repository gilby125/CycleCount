<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cs_AddRemoveShadow.aspx.cs" Inherits="HTMLEditor_cs_AddRemoveShadow" %>
<%@ Register
    Assembly="Obout.Ajax.UI"
    Namespace="Obout.Ajax.UI.HTMLEditor"
    TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head runat="server">
    <title>Editor Sample</title>
    <style type="text/css">
            a {
                   font-size:10pt;font-family:Tahoma
            }
            a:hover {
                   color:crimson;
            }
            .tdText {
                    font:11px Verdana;
                    color:#333333;
            }
    </style>
</head>
<body style="font:12px Verdana;">
<script type="text/JavaScript">
    function enDisClicked() {
        $find("<%= editor.ClientID %>").get_editPanel().setCancelOnPostback();
        return true;
    } 
</script>
    <span class="tdText"><b>Obout.Ajax.UI.HTMLEditor controls</b> - Custom Add/Remove Shadow contextmenu items for image</span>
    <br /><br />
    <table border="0">
        <tr>
            <td valign="top">
                Right click on image and make a shadow for it.<br /><br /> <img alt="" src="SiteImages/MakeShadow.gif" />
            </td>
            <td valign="top" style="padding-left:30px">
                Then you can remove the shadow.<br /><br /> <img alt="" src="SiteImages/RemoveShadow.gif" />
            </td>
        </tr>
    </table><br />
    <form id="form1" runat="server">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />

        <asp:UpdatePanel ID="updatePanel1" runat="server">
            <ContentTemplate>
               <obout:Editor runat="server" Id="editor" EditPanel-NoDrop="true" EditPanel-Height="400px" TopToolbar-PreservePlace="true" Width="100%">
               </obout:Editor>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
    <br /><br /><a href="Default.aspx?type=CSHARP">< Back to examples</a>
</body>
<script type="text/JavaScript">

    // override the base method to prevent contextmenu on some tags
    Obout.Ajax.UI.HTMLEditor.ContextMenu.DesignModeItem.prototype.checkElement = function (retval, element) {
        if (retval) {
            // should we prevent contextmenu here?
            if (element.getAttribute(Obout.Ajax.UI.HTMLEditor.noContextMenuAttribute) && element.getAttribute(Obout.Ajax.UI.HTMLEditor.noContextMenuAttribute).length > 0) {
                return false;
            }
        }
        return retval;
    };

    // override the 'getItemToDelete' method of RemoveImage item (whether to delete image with the wrapper table)
    Obout.Ajax.UI.HTMLEditor.ContextMenu.RemoveImageItem.prototype.getItemToDelete = function () {
        var retval = Obout.Ajax.UI.HTMLEditor.testImage(this.get_designPanel()).image;
        if (retval) {
            // shadowed image?
            if (retval.getAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute) && retval.getAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute).length > 0) {
                // try to get the wrapper table
                retval = Obout.Ajax.UI.HTMLEditor.testTable(this.get_designPanel());
            }
        }
        return retval;
    }

    // declare namespace
    Type.registerNamespace("CustomContextMenu");

    // register class for the custom contextmenu item 'Remove Shadow' (see the code file)
    CustomContextMenu.RemoveShadowItem = function (element) {
        CustomContextMenu.RemoveShadowItem.initializeBase(this, [element]);
    }
    CustomContextMenu.RemoveShadowItem.prototype = {
        checkElement: function (retval, element) {
            if (retval) {
                // show this item if image is shadowed
                if (element.getAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute) && element.getAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute).length > 0) {
                    return true;
                }
                return false;
            } else {
                return retval;
            }
        },

        // override base method
        callMethod: function () {
            // try base method
            if (!CustomContextMenu.RemoveShadowItem.callBaseMethod(this, "callMethod")) return false;
            // design panel
            var editor = this._designPanel;
            //image
            var img = this._relatedElement;
            // save content for undo
            editor._saveContent();
            // remove shadow for the image
            removeShadow(editor, img);
        }
    }
    CustomContextMenu.RemoveShadowItem.registerClass("CustomContextMenu.RemoveShadowItem", Obout.Ajax.UI.HTMLEditor.ContextMenu.DesignModeItem);

    // register class for the custom contextmenu item 'Add Shadow' (see the code file)
    CustomContextMenu.AddShadowItem = function (element) {
        CustomContextMenu.AddShadowItem.initializeBase(this, [element]);
    }
    CustomContextMenu.AddShadowItem.prototype = {
        // override base method
        checkElement: function (retval, element) {
            if (retval) {
                // show this item if image is not shadowed yet
                if (element.getAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute) && element.getAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute).length > 0) {
                    return false;
                }
                return true;
            } else {
                return retval;
            }
        },

        // override base method
        callMethod: function () {
            // try base method
            if (!CustomContextMenu.AddShadowItem.callBaseMethod(this, "callMethod")) return false;
            // design panel
            var editor = this._designPanel;
            //image
            var img = this._relatedElement;
            // save content for undo
            editor._saveContent();
            // make shadow for the image
            makeShadow(editor, img);
        }
    }
    CustomContextMenu.AddShadowItem.registerClass("CustomContextMenu.AddShadowItem", Obout.Ajax.UI.HTMLEditor.ContextMenu.DesignModeItem);

    //
    // Make a Shadow table(wrapper) for image
    //
    function makeShadow(editor, img) {
        if (Obout.Ajax.UI.HTMLEditor.isIE) {
            Obout.Ajax.UI.HTMLEditor._addEvent(img, "dragstart", Obout.Ajax.UI.HTMLEditor.stopDrag);
        } else {
            Obout.Ajax.UI.HTMLEditor._addEvent(img, "draggesture", Obout.Ajax.UI.HTMLEditor.stopDrag);
        }

        var row, cell, ourCell, div;

        var doc = editor.get_doc();       // get Editor's content document
        var shadow = doc.createElement("TABLE"); // create cover table for "Shadow" effect

        // Fill the Shadow table properies
        shadow.style.display = "inline";

        shadow.border = "0";
        shadow.cellSpacing = "0";
        shadow.cellPadding = "0";
        // shadow.id          = (Math.random().toString()).replace(".",""); // create random ID
        shadow.style.borderWidth = "0px";

        // set special attribute to the Shadow table that prohibits contextmenu using on it.
        // this attribute is used on Editor's context menu forming.
        //
        shadow.setAttribute(editor.noContextMenuAttributeName(), "yes");

        // insert a row to the table
        //
        row = shadow.insertRow(shadow.rows.length);

        // set special attribute to the Shadow table's row that prohibits contextmenu using on it.
        // this attribute is used on Editor's context menu forming.
        //
        row.setAttribute(editor.noContextMenuAttributeName(), "yes");

        // insert a cell where the source node be placed
        //
        ourCell = row.insertCell(row.cells.length);
        ourCell.style.fontSize = "0px";
        ourCell.style.fontFamily = "verdana";
        ourCell.style.padding = "0px";
        ourCell.style.margin = "0px";
        ourCell.style.borderWidth = "0px";

        // set special attribute to the Shadow table's cell that prohibits contextmenu using on it.
        // this attribute is used on Editor's context menu forming.
        //
        ourCell.setAttribute(editor.noContextMenuAttributeName(), "yes");

        // insert auxiliary cell
        //
        cell = row.insertCell(row.cells.length);
        cell.vAlign = "top";
        cell.align = "left";
        cell.style.padding = "0px";
        cell.style.margin = "0px";
        cell.style.fontSize = "0px";
        cell.style.fontFamily = "verdana";
        cell.style.borderWidth = "0px";
        cell.style.width = "10px";
        cell.style.backgroundImage = "url(backimages/pagebgright.jpg)";
        cell.style.backgroundRepeat = "repeat-y";
        cell.style.borderWidth = "0px";

        // set special attribute to the Shadow table's cell that prohibits contextmenu using on it.
        // this attribute is used on Editor's context menu forming.
        //
        cell.setAttribute(editor.noContextMenuAttributeName(), "yes");

        // auxiliary div
        //
        div = doc.createElement("DIV");
        div.style.width = "10px";
        div.style.height = "10px";
        div.style.margin = "0px";
        div.style.padding = "0px";
        div.style.backgroundImage = "url(backimages/pagebgtopright.jpg)";
        div.style.backgroundRepeat = "no-repeat";
        div.innerHTML = "&nbsp;";
        div.style.borderWidth = "0px";

        cell.appendChild(div); // append it to cell

        // insert one more row to the table
        //
        row = shadow.insertRow(shadow.rows.length);

        // insert auxiliary cell
        //
        cell = row.insertCell(row.cells.length);
        cell.style.fontSize = "1px";
        cell.style.fontFamily = "arial";
        cell.style.height = "8px";
        cell.vAlign = "top";
        cell.align = "left";
        cell.style.backgroundImage = "url(backimages/pagebgbottomwhite.gif)";
        cell.style.backgroundRepeat = "repeat-x";
        cell.style.borderWidth = "0px";

        // set special attribute to the Shadow table's cell that prohibits contextmenu using on it.
        // this attribute is used on Editor's context menu forming.
        //
        cell.setAttribute(editor.noContextMenuAttributeName(), "yes");

        // auxiliary div
        //
        div = doc.createElement("DIV");
        div.style.width = "10px";
        div.style.height = "8px";
        div.style.margin = "0px";
        div.style.padding = "0px";
        div.style.backgroundImage = "url(backimages/pagebgbottomleftwhite.gif)";
        div.style.backgroundRepeat = "no-repeat";
        div.innerHTML = "&nbsp;";
        div.style.borderWidth = "0px";

        cell.appendChild(div); // append it to cell

        // insert auxiliary cell
        //
        cell = row.insertCell(row.cells.length);
        cell.style.fontSize = "1px";
        cell.style.fontFamily = "arial";
        cell.style.height = "8px";
        cell.style.width = "10px";
        cell.style.backgroundImage = "url(backimages/pagebgbottomright.gif)";
        cell.style.backgroundRepeat = "no-repeat";
        cell.style.borderWidth = "0px";
        cell.innerHTML = "&nbsp;";

        // set special attribute to the Shadow table's cell that prohibits contextmenu using on it.
        // this attribute is used on Editor's context menu forming.
        //
        cell.setAttribute(editor.noContextMenuAttributeName(), "yes");


        /* Shadow Table is ready */

        if (img.tagName && img.tagName.toUpperCase() != "IMG") {
            var place = editor.getSafePlace(img);
            if (place) {
                var parent = place.parentNode;

                parent.insertBefore(img, place);
                parent.removeChild(place);
            }
        }
        // Insert it before our source node
        //
        img.parentNode.insertBefore(shadow, img);

        // move the source node inside the Shadow table
        //
        ourCell.appendChild(img);

        // The sourse table should be attached to the Shadow table.
        // Set special "attachedId" attribute to the source node.
        // It is used by Editor's context menu processor. 
        //
        img.setAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute, "yes");
    }

    //
    // Remove Shadow table(wrapper) for the source node
    //
    function removeShadow(editor, img) {
        if (Obout.Ajax.UI.HTMLEditor.isIE) {
            Obout.Ajax.UI.HTMLEditor._removeEvent(img, "dragstart", Obout.Ajax.UI.HTMLEditor.stopDrag);
        } else {
            Obout.Ajax.UI.HTMLEditor._removeEvent(img, "draggesture", Obout.Ajax.UI.HTMLEditor.stopDrag);
        }

        // get shadow table
        var shadowNode = editor.getAttachedElement(img);
        if (img.getAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute) && img.getAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute).length > 0) {
            var par = img.parentNode;

            while (par && par.tagName.toUpperCase() != "BODY") {
                if (par.tagName.toUpperCase() == "TABLE") {
                    shadowNode = par;
                    break;
                }

                par = par.parentNode;
            }
        }

        if (shadowNode != null) {
            // Insert source node before it's shadow
            //
            shadowNode.parentNode.insertBefore(img, shadowNode);

            // Remove the shadow table
            //
            shadowNode.parentNode.removeChild(shadowNode);

            // remove "attachedId" attribute from the source node
            //
            img.removeAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute);
        }
    }

    // trick for old versions of the DLL
    if (typeof Obout.Ajax.UI.HTMLEditor.DesignPanel.prototype.getAttachedElement != "function") {
        Obout.Ajax.UI.HTMLEditor.DesignPanel.prototype.getAttachedElement = function (element) {
            var shadowNode = null;
            if (element.getAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute) && element.getAttribute(Obout.Ajax.UI.HTMLEditor.attachedIdAttribute).length > 0) {
                var par = element.parentNode;

                while (par && par.tagName.toUpperCase() != "BODY") {
                    if (par.tagName.toUpperCase() == "TABLE") {
                        shadowNode = par;
                        break;
                    }

                    par = par.parentNode;
                }
            }
            return shadowNode;
        }
    }

</script>
</html>