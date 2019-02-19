Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Data
Imports System.Data.OleDb

Partial Public Class SmartImage_vb_DataTableDataSource
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim connectionString As String = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & System.Web.HttpContext.Current.Server.MapPath(ResolveUrl("~/App_Data/FilesRepository.mdb")) & ";"
        Dim connection As New OleDbConnection()
        Try
            connection.ConnectionString = connectionString
            connection.Open()

            Dim sqlString As String = "Select * from tbImage"
            Dim eAdapter As New OleDbDataAdapter(sqlString, connection)
            Dim eTable As New DataTable()
            Dim CommandBuilder As New OleDbCommandBuilder(eAdapter)
            eAdapter.Fill(eTable)

            imageset.DataSource = eTable
            imageset.DataBind()
        Finally
            connection.Close()
            connection.Dispose()
        End Try

    End Sub
End Class
