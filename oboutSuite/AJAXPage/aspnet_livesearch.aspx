<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage"%>
<%@ Page Language="C#" ASPCOMPAT="TRUE" Debug="true" Inherits="OboutInc.oboutAJAXPage"%>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obcal" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_Net" %>
<%@ Import Namespace="System.Xml" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.OleDb" %>
<script language="C#" runat="server">
    void Page_Load(object sender, EventArgs e) {
        
		if (!IsPostBack)
		{
			PopulateWithData();
			myCalendar1.SelectedDate = DateTime.Now.AddDays(7);
			myCalendar1.DateMin = DateTime.Now.AddDays(7);
			myCalendar2.SelectedDate = DateTime.Now.AddDays(10);
			myCalendar2.DateMin = DateTime.Now.AddDays(7);
		}
		
		if (IsCallback && Session["SearchParams"] != null)
		{
			Search();
			Session["SearchParams"] = null;
		}
	}
	
	public void PopulateWithData()
    {
        // Setting the connection
        OleDbConnection oConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/hotels.mdb"));
        oConn.Open();

        // Run the query to retrieve the words that start with the give text
        string sQuery = "SELECT DISTINCT LocationID, Location FROM Location ORDER BY Location ASC";
        OleDbCommand oCommand = new OleDbCommand(sQuery);
        oCommand.Connection = oConn;
        OleDbDataReader oReader = oCommand.ExecuteReader();

        // Looping through the database records and adding them to the XML string
        while (oReader.Read())
        {
            ComboBoxItem item1 = new ComboBoxItem();
            item1.Value = oReader.GetInt32(0).ToString();
            item1.Text = oReader.GetString(1);
            cboLocation.Items.Add(item1);
        }
        
		// Closing the connection
        oReader.Close();
        oConn.Close();
    }
	
	// set the search params - keep in session object
	public void SetSearchParams(string location, string locationID, string checkIn, string checkOut, string rooms, string adults, string children)
	{
		SearchParams sp = new SearchParams();
		sp.location = location;
		sp.locationID = locationID;
		sp.checkIn = checkIn;
		sp.checkOut = checkOut;
		sp.rooms = rooms;
		sp.adults = adults;
		sp.children = children;
		
		Session["SearchParams"] = sp;
	}
	
	// search - in real life application - use all the search params to retreive the data from the database
	public void Search()
	{
		OleDbConnection myConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/hotels.mdb"));
		myConn.Open();
		
		// get random results from the database
		if (Session["random"] == null) Session["random"] = 1;
		else Session["random"] = Int32.Parse(Session["random"].ToString()) % 5 + 1;
		string query = "SELECT name, stars, description, price, image FROM hotels where locationID = " + Session["random"].ToString();
		
		OleDbCommand myComm = new OleDbCommand(query, myConn);
		OleDbDataReader myReader = myComm.ExecuteReader();
		
		hotelList.DataSource = myReader;
		hotelList.DataBind();
		
		// populate search params details - header of the search panel
		lDestination.Text = ((SearchParams)Session["SearchParams"]).location;
		lCheckIn.Text = ((SearchParams)Session["SearchParams"]).checkIn;
		lCheckOut.Text = ((SearchParams)Session["SearchParams"]).checkOut;
		lAdults.Text = ((SearchParams)Session["SearchParams"]).adults;
		lChildren.Text = ((SearchParams)Session["SearchParams"]).children;
		lRooms.Text = ((SearchParams)Session["SearchParams"]).rooms;
	}
	
	public class SearchParams
	{
		public SearchParams(){}
		
		private string _location;
		private string _locationID;
		private string _checkIn;
		private string _checkOut;
		private string _rooms;
		private string _adults;
		private string _children;
		
		public string location
		{
			get { return _location; }
			set { _location = value; }
		}
		public string locationID
		{
			get { return _locationID; }
			set { _locationID = value; }
		}
		public string checkIn
		{
			get { return _checkIn; }
			set { _checkIn = value; }
		}
		public string checkOut
		{
			get { return _checkOut; } 
			set { _checkOut = value; }
		}
		public string rooms
		{
			get { return _rooms; }
			set { _rooms = value; }
		}
		public string adults
		{
			get { return _adults; }
			set { _adults = value; }
		}
		public string children
		{
			get { return _children; }
			set { _children = value; }
		}
	}
	
</script>

<html>
	<head runat="server">
		<script language="JavaScript" type="text/javascript">
			function Search()
			{
			    var location = cboLocation.options[cboLocation.selectedIndex()].text;
				var locationID = cboLocation.options[cboLocation.selectedIndex()].value;
				
				if (locationID == "")
				{
					alert("Please select a location first");
					return;
				}
				var checkIn = document.getElementById('txtCheckIn').value;
				var checkOut = document.getElementById('txtCheckOut').value;
				var rooms = document.getElementById('sRooms').value;
				var adults = document.getElementById('sAdults').value;
				var children = document.getElementById('sChildren').value;
				
				ob_post.AddParam("location", location);
				ob_post.AddParam("locationID", locationID);
				ob_post.AddParam("checkIn", checkIn);
				ob_post.AddParam("checkOut", checkOut);
				ob_post.AddParam("rooms", rooms);
				ob_post.AddParam("adults", adults);
				ob_post.AddParam("children", children);
				ob_post.post(null, "SetSearchParams", SearchResults);
			}
			
			function SearchResults()
			{
				document.getElementById('divSearchBestDeal').style.display = 'none';
				
				ob_post.UpdatePanel("cp_results");
			}
		</script>

		<style type="text/css">
			.tdText {
				font:11px Verdana;
				color:#333333;
			}
			.title {
				font-size: X-Large; 
				padding: 20px; 
				border-bottom: 2px solid gray; 
				width: 100%; 
			}
		</style>
		<title>Live search engine</title>
	</head>
	<body>
    <form runat="server">
		<table border="0">
			<tr>
				<td valign="top" width="630" colspan="4">
					<span class="title">Live search engine</span><br /><br /><br />
				</td>
			</tr>
			<tr>
				<td class="tdText" align="top" width="240px" valign="top" height="400px">
					<table width="100%"  style="border-right:1px solid gray;border-bottom:1px solid gray;border-top:1px solid gray;border-left:1px solid gray">
						<tr>
							<td colspan="2" style="padding-bottom:10px">
								&nbsp;&nbsp;<b style="color:crimson;font-size:12px;text-decoration:underline;">Search Hotel</b>
							</td>
						</tr>
						<tr>
							<td class="tdText" style="font-size:10px;">
								<b>Location:</b>
							</td>
							<td>
								<obout:Combobox id="cboLocation" Width="157" Height="125" runat="server">
								</obout:Combobox>
							</td>
						</tr>
						<tr>
							<td colspan="2" class="tdText" style="font-size:9px">
								Start typing the location to get suggestions.
							</td>
						</tr>
						<tr>
							<td colspan="2" class="tdText" style="padding-top:15px;font-size:10px;">
								<b>Select Date & Guest Information</b>
							</td>
						</tr>
						<tr>
							<td class="tdText" style="font-size:10px;">
								Check In:
							</td>
							<td>
								<input type="text" id="txtCheckIn" value='<%= DateTime.Now.AddDays(7).ToString("MM/dd/yyyy") %>' readonly="true" style="width:125px;height:20px" />
								<obcal:Calendar id="myCalendar1" runat="server" 
												DatePickerMode="true"
												MonthWidth="175"
												Columns="2"
												MonthHeight="140"
												TextBoxId="txtCheckIn" 
												DatePickerImagePath ="images/icon2.gif"
												ShortDayNames="Su,Mo,Tu,We,Th,Fr,Sa" MonthMarginWidth="4" />
							</td>
						</tr>
						<tr>
							<td class="tdText" style="font-size:10px;">
								Check out:
							</td>
							<td>
								<input type="text" id="txtCheckOut" value='<%= DateTime.Now.AddDays(10).ToString("MM/dd/yyyy") %>' readonly="true" style="width:125px;height:20px" />
								<obcal:Calendar id="myCalendar2" runat="server" 
												DatePickerMode="true"
												BeginDateCalendarId="myCalendar1"
												MonthWidth="175"
												Columns="2"
												MonthHeight="140"
												TextBoxId="txtCheckOut" 
												DatePickerImagePath ="images/icon2.gif"
												ShortDayNames="Su,Mo,Tu,We,Th,Fr,Sa" MonthMarginWidth="4" />
							</td>
						</tr>
						<tr>
							<td colspan="2" class="tdText" style="padding-top:15px;font-size:10px">
								<b>Rooms & Guests</b>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<table>
									<tr>
										<td class="tdText" style="font-size:9px" style="padding-right:5px">
											Rooms
										</td>
										<td class="tdText" style="font-size:9px" style="padding-right:5px">
											Adults
										</td>
										<td class="tdText" style="font-size:9px" style="padding-right:5px">
											Children
										</td>
									</tr>
									<tr>
										<td>
											<select id="sRooms">
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
											</select>
										</td>
										<td>
											<select id="sAdults">
												<option value="1">1</option>
												<option value="2" selected="true">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
											</select>
										</td>
										<td>
											<select id="sChildren">
												<option value="1">1</option>
												<option value="2">2</option>
											</select>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="right" style="padding-top:20px">
								<input type="button" value="Search >>" style="border:1px solid black;background-color:gray;color:white;height:20px;cursor:pointer;" onclick="Search()" />
							</td>
						</tr>
					</table>
				</td>
				<td valign="top" width="400px" align="center">
					<div id="divSearchBestDeal" class="tdText" style="color:red;border:0px solid gray;height:170px">
						Search for the best deal!
					</div>
					<oajax:CallbackPanel runat="server" ID="cp_results" RenderMethod="OnCallback">
						<content style="width:400px;height:169px;padding:0px;">
							<table width="100%" cellpadding="0" cellspacing="0">
								<tr>
									<td valign="top" class="tdText" style="font-size:9px;padding-left:5px;padding-top:4px;border:1px solid gray;height:60px;">
										<b>Destination: </b><asp:Literal id="lDestination" runat="server" /> <br />
										<b>Dates: </b><asp:Literal id="lCheckIn" runat="server" /> - <asp:Literal id="lCheckOut" runat="server" /> <br />
										<b>Guests: </b><asp:Literal id="lAdults" runat="server" /> adult(s), <asp:Literal id="lChildren" runat="server" /> child(ren) in <asp:Literal id="lRooms" runat="server" /> room(s).<br />
										<b>Results: </b>3 <br />
									</td>
								</tr>
								<tr>
									<td width="100%">
										<table width=100% height=100% cellpadding=0 cellspacing=0>
											<tr>
												<td align=center valign="top" width="100%" style="padding-top:3px;">
													<asp:DataList id="hotelList" runat="server" cellspacing="3" cellpadding="0">
														<ItemTemplate>
															<table style="width:100%;height:100px;border:1px solid gray;padding-bottom:3px;" cellspacing="0" cellpadding="0">
																<tr>
																	<td colspan="3" style="width:100%;background-color:#4F5457;height:20px;" >
																		<table cellpadding="0" cellspacing="0" width="100%">
																			<tr>
																				<td align="left" width="65%" style="font-weight:bold;font-size:9px;color:white;cursor:pointer;padding-left:5px" class="tdText">
																					<%# DataBinder.Eval(Container.DataItem, "name") %>
																				</td>
																				<td align="right">
																					<img src="images/hotels/<%# DataBinder.Eval(Container.DataItem, "stars") %>stars.gif" />
																				</td>
																			</tr>
																		</table>
																	</td>
																</tr>
																<tr>
																	<td align="left" style="padding:2px;width:70px;">
																		<img width="75px" src="images/hotels/<%# DataBinder.Eval(Container.DataItem, "image") %>.jpg" />
																	</td>
																	<td class="tdText" valign="top" style="padding-left:4px;">
																		<%# DataBinder.Eval(Container.DataItem, "description") %>
																		&nbsp;<nobr><a style="cursor:pointer;text-decoration:underline">more info</a></nobr>
																	</td>
																	<td>
																		<div style="width:50px;font-size:18px;font-weight:bold;color:red;padding-right:5px;padding-left:5px;">
																			$<%# DataBinder.Eval(Container.DataItem, "price") %>
																		</div>
																	</td>
																</tr>
															</table>
														</ItemTemplate>
													</asp:DataList>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</content>
						<loading style="width:400px;height:169px;padding:0px;">
							<table width=100% height=100% cellpadding=0 cellspacing=0>
								<tr>
									<td align=center>
										<img src="loading_icons/7.gif">
									</td>
								</tr>
							</table>
						</loading>
					</oajax:CallbackPanel>
				</td>
			</tr>
		</table>
		<br /><br /><br />
	</form>
	<a style="font-family:Tahoma;font-size:12px" href="Default.aspx?type=ASPNET">� Back to examples</a>
	</body>
</html>