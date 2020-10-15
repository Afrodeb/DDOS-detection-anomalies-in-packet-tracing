<%@page import="java.util.ArrayList"%>
<%@page import="models.worker"%>
<%@include file="header.jsp"%>
        <div id="page-wrapper">

            
            <div class="row">
                 <!--  page header -->
                <div class="col-lg-12">
                    <h1 class="page-header">Blocked I.Ps</h1>
                </div>
                 <!-- end  page header -->
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Details
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>I.P Address</th>
                                            <th>Port</th>
                                            <th>Domain</th>
                                            <th>UUID</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                        worker w=new worker();
                                        ArrayList b=w.blacklist();
                                        int c=b.size();
                                        for(int x=0;x < c; x++){
                                            ArrayList profile=(ArrayList)b.get(x);
                                        %>
                                        <tr class="odd gradeX">
                                            <td><% out.print(profile.get(0)); %></td>
                                            <td><% out.print(profile.get(1)); %></td>
                                            <td><% out.print(profile.get(2)); %></td>
                                            <td class="center"><% out.print(profile.get(3)); %></td>
                                            <td class="center">X</td>
                                        </tr>
                                       <%
                                        }
                                       %> 
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>
                    <!--End Advanced Tables -->
                </div>
            </div>
          
           
           
        </div>
        <!-- end page-wrapper -->

    </div>
    <%@include file="footer.jsp" %>