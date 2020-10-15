<%@include file="header.jsp" %>
        <div id="page-wrapper" >
            <div class="row">
                <!-- page header-->
                <div class="col-lg-12">
                    <h1 class="page-header">Packet Analysis</h1>
                </div>
                 <!-- end page header-->
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <!-- Moving Line Chart -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Live Packet Logger
                           <input type="button" id="start" class="btn btn-primary" value="Start Monitor">
                        </div>
                        <div class="panel-body">
                            <!--<div class="flot-chart">
                                <div class="flot-chart-content" id="flot-line-chart-moving"></div>
                            </div>
                            
                            -->
                             <div class="table-responsive" id="intro">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>Protocol</th>
                                            <th>Source Address</th>
                                            <th>Destination Address</th>
                                            <th>Time</th>                                            
                                            <th>Packet Length</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody id="monitor">
                                        
                                      
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!--End Moving Line Chart -->
                </div>
               
                
            </div>
                        <div class="row">
                            <div class="col-lg-12">                                
                                <div id="container1" style="position: relative; width: 80%; max-height: 450px;"></div>  
                            </div>
                        </div>

                            
            
            
        </div>
        <!-- end page-wrapper -->

    </div>
    <%@include file="footer.jsp"%>