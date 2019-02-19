using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Obout.Ajax.UI;


public partial class FileManager_cs_GetFileServerSide : System.Web.UI.Page
{
    protected void fileselected_postback(object sender, EventArgs e)
    {
        Obout.Ajax.UI.FileManager.FileManager manager = sender as Obout.Ajax.UI.FileManager.FileManager;
        Result.Controls.Clear();
        Result.Controls.Add(new LiteralControl("<br /><b>Parameters of the selected file</b><br />"));
        Table table = new Table();
        table.CellSpacing = 3;
        table.BorderWidth = new Unit(1, UnitType.Pixel);
        table.BorderColor = System.Drawing.Color.FromName("gray");
        Result.Controls.Add(table);

        table.Rows.Add(addRow("Url", manager.FileUrl, System.Drawing.Color.FromName("lightgray")));
        table.Rows.Add(addRow("Title", manager.FileTitle, System.Drawing.Color.FromName("white")));
        table.Rows.Add(addRow("Width", manager.FileWidth, System.Drawing.Color.FromName("lightgray")));
        table.Rows.Add(addRow("Height", manager.FileHeight, System.Drawing.Color.FromName("white")));
        table.Rows.Add(addRow("Info", manager.FileInfo, System.Drawing.Color.FromName("lightgray")));
        //table.Rows.Add(addRow("File picked", manager.FilePicked.ToString(), System.Drawing.Color.FromName("white")));
    }

    private TableRow addRow(string name, string value, System.Drawing.Color backcolor)
    {
        TableRow row;
        TableCell cell;

        row = new TableRow();
        row.BackColor = backcolor;
        cell = new TableCell();
        cell.HorizontalAlign = HorizontalAlign.Left;
        row.Cells.Add(cell);
        cell.Controls.Add(new LiteralControl("<b>" + name + "</b>:"));
        cell = new TableCell();
        cell.HorizontalAlign = HorizontalAlign.Left;
        row.Cells.Add(cell);
        cell.Controls.Add(new LiteralControl(value));
        return row;
    }
}