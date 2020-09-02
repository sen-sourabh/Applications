<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.jsoup.Jsoup"%>
<%@include file="header.jsp"%>
<%
    final String url = "https://www.worldometers.info/coronavirus/";
    try{
        int i = 0;
        String str="";
        final Document document = Jsoup.connect(url).get();
//        System.out.println(document.outerHtml());
%>
            <div class="container">
                <br>
                <center>
                    <h2>COVID-19 CORONAVIRUS PANDEMIC</h2>
                    <br>
                </center>
                <h4>Reported Cases and Deaths by Country, Territory, or Conveyance</h4>
                <br>
                <p style="text-align:justify;">The coronavirus COVID-19 is affecting 213 countries and territories around the world and 2 international
                    conveyances. The day is reset after midnight GMT+0. The list of countries and territories and their continental 
                    regional classification is based on the United Nations Geoscheme. Sources are provided under "Latest Updates". 
                    Learn more about Worldometer's COVID-19 data : 
                </p>
                <br>
                <table class="table table-bordered table-hover table-responsive-lg">
                    <thead>
                        <th>S.No.</th>
                        <th>Country</th>
                        <th>Total Cases</th>
                        <th>Total Deaths</th>
                        <th>Total Recovered</th>
                        <th>Active Cases</th>
                        <th>Serious / Critical</th>
                        <th>Total Tests </th>
                        <th>Population</th>
                    </thead>
                    <tbody>
<%
        for(Element row : document.select("table.main_table_countries tbody tr")) {
%>
            
                <%
                    if(i > 215 || row.select("td:nth-of-type(2)").text().equals("North America") || row.select("td:nth-of-type(2)").text().equals("South America") || row.select("td:nth-of-type(2)").text().equals("Europe") || row.select("td:nth-of-type(2)").text().equals("Asia") || row.select("td:nth-of-type(2)").text().equals("Africa") || row.select("td:nth-of-type(2)").text().equals("Oceania") || row.select("td:nth-of-type(2)").text().equals("")) {
                        continue;
                    } else {
                        final String sno = Integer.toString(i);
                        final String country = row.select("td:nth-of-type(2)").text();
                        final String t_cases = row.select("td:nth-of-type(3)").text();
                        final String t_deaths = row.select("td:nth-of-type(5)").text();
                        final String t_recovereds = row.select("td:nth-of-type(7)").text();
                        final String active_cases = row.select("td:nth-of-type(9)").text();
                        final String serious_critical = row.select("td:nth-of-type(10)").text();
                        final String t_tests = row.select("td:nth-of-type(13)").text();
                        final String population = row.select("td:nth-of-type(15)").text();
                %>
                    <tr>
                        <td><%=sno%></td>
                        <td><%=country%></td>
                        <td><%=t_cases%></td>
                        <td><%=t_deaths%></td>
                        <td><%=t_recovereds%></td>
                        <td><%=active_cases%></td>
                        <td><%=serious_critical%></td>
                        <td><%=t_tests%></td>
                        <td><%=population%></td>
                    </tr>
                <%
                    }
                    i++;
                %>
<%
        }
%>
                    </tbody>
                </table>
            </div>
<%
    } catch(Exception ex) {
        System.out.println("Exception : " + ex.toString());
    }

%>
<%@include file="footer.jsp"%>