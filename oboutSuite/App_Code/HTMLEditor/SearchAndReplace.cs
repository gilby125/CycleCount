using System;
using System.Data;
using System.Data.OleDb;
using System.ComponentModel;
using System.ComponentModel.Design;
using System.ComponentModel.Design.Serialization;
using System.Reflection;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Security.Permissions;
using System.Collections;
using System.Collections.ObjectModel;
using System.Text;
using System.Text.RegularExpressions;
using System.Globalization;
using System.IO;
using Obout.Ajax.UI;
using Obout.Ajax.UI.HTMLEditor;
using Obout.Ajax.UI.HTMLEditor.ToolbarButton;

namespace CustomToolbarButton
{
    /// <summary>
    /// Search & Replace button
    /// </summary>
    [ParseChildren(true)]
    [PersistChildren(false)]
    [RequiredScript(typeof(OpenPopupButton))]
    [ButtonsList(true)]
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")]
    public class SearchAndReplace : Obout.Ajax.UI.HTMLEditor.ToolbarButton.OpenPopupButton
    {
        #region [ Properties ]

        // popup to be opened on click
        public override Obout.Ajax.UI.HTMLEditor.Popups.Popup RelatedPopup
        {
            get
            {
                if (base.RelatedPopup == null)
                {
                    base.RelatedPopup = new CustomPopups.SearchAndReplacePopup();
                }
                return base.RelatedPopup;
            }
        }

        // modes of EditPanel when this button can be shown in the toolbar
        public sealed override Collection<ActiveModeType> ActiveModes
        {
            get
            {
                return new Collection<ActiveModeType>() { ActiveModeType.Design, ActiveModeType.Html };
            }
        }

        // folder with images for the button
        protected override string ButtonImagesFolder
        {
            get { return "~/App_Obout/HTMLEditor/customButtons/"; }
        }

        // base name of the button's image
        protected override string BaseImageName
        {
            get { return "ed_search"; }
        }

        // default button's title if not found in Localization file
        public override string DefaultToolTip
        {
            get { return "Search and replace"; }
        }

        #endregion
    }
}

namespace CustomPopups
{
    /// <summary>
    /// Search & Replace popup
    /// </summary>
    [RequiredScript(typeof(Obout.Ajax.UI.HTMLEditor.Popups.Popup))] // all popup's scripts must be loaded
    [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Maintainability", "CA1501:AvoidExcessiveInheritance")]
    public class SearchAndReplacePopup : Obout.Ajax.UI.HTMLEditor.Popups.OkCancelPopup
    {
        #region [ Fields ]

        private TextBox _Search = null;
        private TextBox _ReplaceWith = null;
        private CheckBox _MatchCase = null;
        private Obout.Ajax.UI.HTMLEditor.Popups.PopupBGIButton SearchNext = null;
        private Obout.Ajax.UI.HTMLEditor.Popups.PopupBGIButton Replace = null;
        private Obout.Ajax.UI.HTMLEditor.Popups.PopupBGIButton ReplaceAll = null;

        #endregion

        #region [ Properties ]

        protected virtual TextBox Search // Field in the popup
        {
            get
            {
                if (_Search == null)
                {
                    _Search = new TextBox();
                    _Search.Style["width"] = "200px";
                    _Search.Style["height"] = "15px";
                    _Search.MaxLength = 1000;
                    _Search.ID = "";
                }
                return _Search;
            }
        }

        protected virtual TextBox ReplaceWith // Field in the popup
        {
            get
            {
                if (_ReplaceWith == null)
                {
                    _ReplaceWith = new TextBox();
                    _ReplaceWith.Style["width"] = "200px";
                    _ReplaceWith.Style["height"] = "15px";
                    _ReplaceWith.MaxLength = 1000;
                    _ReplaceWith.ID = "";
                }
                return _ReplaceWith;
            }
        }

        protected virtual CheckBox MatchCase // Field in the popup
        {
            get
            {
                if (_MatchCase == null)
                {
                    _MatchCase = new CheckBox();
                    _MatchCase.ID = "";
                }
                return _MatchCase;
            }
        }

        // what client-side type to initiate
        protected override string ClientControlType
        {
            get { return "CustomPopups.SearchAndReplacePopup"; }
        }

        // what file in the client-side type is located
        protected override string ScriptPath
        {
            get { return "~/App_Obout/HTMLEditor/Scripts/SearchAndReplacePopup.js"; }
        }

        // it's a floating popup
        protected override bool AttachedToButton
        {
            get
            {
                return false;
            }
        }

        // Title of the popup if not found in Localization
        protected override string DefaultTitle
        {
            get { return "Search & Replace"; }
        }
        #endregion

        #region [ Methods ]

        // fill the popup's content
        protected override void OkCancelFillContent()
        {
            Table table = new Table();
            HtmlGenericControl holder;
            table.Attributes.Add("border", "0");
            table.Attributes.Add("cellspacing", "0");
            table.Attributes.Add("cellpadding", "2");

            TableRow row;
            TableCell cell;

            Table tableInner;
            TableRow rowInner;
            TableCell cellInner;

            row = new TableRow();
            table.Rows.Add(row);

            cell = new TableCell();
            row.Cells.Add(cell);
            cell.HorizontalAlign = HorizontalAlign.Left;
            cell.VerticalAlign = VerticalAlign.Top;

            tableInner = new Table();
            tableInner.Attributes.Add("border", "0");
            tableInner.Attributes.Add("cellspacing", "0");
            tableInner.Attributes.Add("cellpadding", "2");
            cell.Controls.Add(tableInner);

            if (Search != null) // the property is not overridden to 'null'
            {
                rowInner = new TableRow();
                tableInner.Rows.Add(rowInner);

                cellInner = new TableCell();
                rowInner.Cells.Add(cellInner);
                holder = new HtmlGenericControl("span");
                cellInner.Controls.Add(holder);
                holder.Controls.Add(new LiteralControl(GetField("Search", "Search"))); // check for localization
                cellInner.HorizontalAlign = HorizontalAlign.Left;
                cellInner.VerticalAlign = VerticalAlign.Middle;
                cellInner.Controls.Add(new LiteralControl(": "));

                cellInner = new TableCell();
                cellInner.HorizontalAlign = HorizontalAlign.Left;
                cellInner.VerticalAlign = VerticalAlign.Middle;
                cellInner.Style[HtmlTextWriterStyle.WhiteSpace] = "nowrap";
                rowInner.Cells.Add(cellInner);
                Search.Style[HtmlTextWriterStyle.VerticalAlign] = "middle";
                cellInner.Controls.Add(Search);
            }
            if (ReplaceWith != null) // the property is not overridden to 'null'
            {
                rowInner = new TableRow();
                tableInner.Rows.Add(rowInner);

                cellInner = new TableCell();
                rowInner.Cells.Add(cellInner);
                holder = new HtmlGenericControl("span");
                cellInner.Controls.Add(holder);
                holder.Controls.Add(new LiteralControl(GetField("ReplaceWith", "Replace"))); // check for localization
                cellInner.HorizontalAlign = HorizontalAlign.Left;
                cellInner.VerticalAlign = VerticalAlign.Middle;
                cellInner.Controls.Add(new LiteralControl(": "));

                cellInner = new TableCell();
                cellInner.HorizontalAlign = HorizontalAlign.Left;
                cellInner.VerticalAlign = VerticalAlign.Middle;
                cellInner.Style[HtmlTextWriterStyle.WhiteSpace] = "nowrap";
                rowInner.Cells.Add(cellInner);
                ReplaceWith.Style[HtmlTextWriterStyle.VerticalAlign] = "middle";
                cellInner.Controls.Add(ReplaceWith);
            }
            if (MatchCase != null) // the property is not overridden to 'null'
            {
                rowInner = new TableRow();
                tableInner.Rows.Add(rowInner);

                cellInner = new TableCell();
                rowInner.Cells.Add(cellInner);
                holder = new HtmlGenericControl("span");
                cellInner.Controls.Add(holder);
                holder.Controls.Add(new LiteralControl(GetField("MatchCase", "Match case"))); // check for localization
                cellInner.HorizontalAlign = HorizontalAlign.Left;
                cellInner.VerticalAlign = VerticalAlign.Middle;
                cellInner.Controls.Add(new LiteralControl(": "));

                cellInner = new TableCell();
                cellInner.HorizontalAlign = HorizontalAlign.Left;
                cellInner.VerticalAlign = VerticalAlign.Middle;
                cellInner.Style[HtmlTextWriterStyle.WhiteSpace] = "nowrap";
                rowInner.Cells.Add(cellInner);
                MatchCase.Style[HtmlTextWriterStyle.VerticalAlign] = "middle";
                cellInner.Controls.Add(MatchCase);
            }

            cell = new TableCell();
            row.Cells.Add(cell);
            cell.HorizontalAlign = HorizontalAlign.Left;
            cell.VerticalAlign = VerticalAlign.Top;

            tableInner = new Table();
            tableInner.Attributes.Add("border", "0");
            tableInner.Attributes.Add("cellspacing", "0");
            tableInner.Attributes.Add("cellpadding", "2");
            cell.Controls.Add(tableInner);

            if (Search != null) // the property is not overridden to 'null'
            {
                SearchNext = new Obout.Ajax.UI.HTMLEditor.Popups.PopupBGIButton();
                SearchNext.Name = "searchNext";
                SearchNext.Text = "&nbsp;&nbsp;" + GetButton("SearchNext", "search next") + "&nbsp;&nbsp;";
                SearchNext.ID = "";

                rowInner = new TableRow();
                tableInner.Rows.Add(rowInner);
                cellInner = new TableCell();
                rowInner.Cells.Add(cellInner);
                cellInner.Controls.Add(SearchNext);
            }
            if (ReplaceWith != null) // the property is not overridden to 'null'
            {
                Replace = new Obout.Ajax.UI.HTMLEditor.Popups.PopupBGIButton();
                Replace.Name = "replace";
                Replace.Text = "&nbsp;&nbsp;" + GetButton("Replace", "replace") + "&nbsp;&nbsp;";
                Replace.ID = "";

                rowInner = new TableRow();
                tableInner.Rows.Add(rowInner);
                cellInner = new TableCell();
                rowInner.Cells.Add(cellInner);
                cellInner.Controls.Add(Replace);

                ReplaceAll = new Obout.Ajax.UI.HTMLEditor.Popups.PopupBGIButton();
                ReplaceAll.Name = "replaceAll";
                ReplaceAll.Text = "&nbsp;&nbsp;" + GetButton("ReplaceAll", "replace all") + "&nbsp;&nbsp;";
                ReplaceAll.ID = "";

                rowInner = new TableRow();
                tableInner.Rows.Add(rowInner);
                cellInner = new TableCell();
                rowInner.Cells.Add(cellInner);
                cellInner.Controls.Add(ReplaceAll);
            }

            Content.Add(table);
        }

        // override the base method
        protected override void DescribeComponent(ScriptComponentDescriptor descriptor)
        {
            // Register fields and handlers for use in client-side

            if (Search != null) RegisteredFields.Add(new Obout.Ajax.UI.HTMLEditor.Popups.RegisteredField("search", Search));
            if (ReplaceWith != null) RegisteredFields.Add(new Obout.Ajax.UI.HTMLEditor.Popups.RegisteredField("replaceWith", ReplaceWith));
            if (MatchCase != null) RegisteredFields.Add(new Obout.Ajax.UI.HTMLEditor.Popups.RegisteredField("matchCase", MatchCase));
            if (SearchNext != null) RegisteredHandlers.Add(new Obout.Ajax.UI.HTMLEditor.Popups.RegisteredField("searchNext", SearchNext));
            if (Replace != null) RegisteredHandlers.Add(new Obout.Ajax.UI.HTMLEditor.Popups.RegisteredField("replace", Replace));
            if (ReplaceAll != null) RegisteredHandlers.Add(new Obout.Ajax.UI.HTMLEditor.Popups.RegisteredField("replaceAll", ReplaceAll));

            base.DescribeComponent(descriptor);
        }
        #endregion
    }
}