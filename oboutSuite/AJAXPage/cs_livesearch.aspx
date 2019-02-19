<%@ Register TagPrefix="oajax" Namespace="OboutInc" Assembly="obout_AJAXPage"%>
<%@ Page Language="C#" Src="cs_livesearch.aspx.cs" Inherits="cs_livesearch"%>
<%@ Register TagPrefix="obout" Namespace="Obout.ComboBox" Assembly="obout_ComboBox" %>
<%@ Register TagPrefix="obcal" Namespace="OboutInc.Calendar2" Assembly="obout_Calendar2_Net" %>

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
								<input type="text" id="txtCheckIn"  value='<%= DateTime.Now.AddDays(7).ToString("MM/dd/yyyy") %>' readonly="true" style="width:125px;height:20px" />
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
								<input type="text" id="txtCheckOut"  value='<%= DateTime.Now.AddDays(10).ToString("MM/dd/yyyy") %>' readonly="true" style="width:125px;height:20px" />
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
	<a style="font-family:Tahoma;font-size:12px" href="Default.aspx?type=CSHARP">� Back to examples</a>
	</body>
</html>