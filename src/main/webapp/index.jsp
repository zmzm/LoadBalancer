<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Load Balancer</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.0/css/jquery.dataTables.css">
    <link href="/static/css/sticky-footer.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
    <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
    <script>
        $(document).ready(function () {
            var userCount1;
            var gameState1;
            var userCount2;
            var gameState2;
            (function () {
                setInterval(function () {
                    $.ajax({
                        type: 'GET',
                        url: 'http://localhost:8080/api/serverInfo',
                        success: function (data) {
                            console.log(data);
                            document.getElementById("usersCount").innerHTML = 'Users count: ' + data.usersCount;
                            document.getElementById("serverState").innerHTML = 'Server state: ' +  data.serverState;
                            userCount1 = data.usersCount;
                            gameState1 = data.gameState;
                        },
                        error: function () {
                        }
                    })
                }, 1500);
            })();
            (function () {
                setInterval(function () {
                    $.ajax({
                        type: 'GET',
                        url: 'http://localhost:8088/api/serverInfo',
                        success: function (data) {
                            console.log(data);
                            document.getElementById("usersCount1").innerHTML = 'Users count: ' + data.usersCount;
                            document.getElementById("serverState1").innerHTML = 'Server state: ' +  data.serverState;
                            userCount2 = data.usersCount;
                            gameState2 = data.gameState;
                        },
                        error: function () {
                        }
                    })
                }, 1500);
            })();
            $('#connect').on('click', function () {
                if(userCount1 >= 1 || gameState1 != 0)
                {
                    if(userCount2 >=1 || gameState2 != 0)
                    {
                        alert("Connection is not possible. Please wait.")
                    }
                    else
                    {
                        window.location.replace("http://localhost:8088/");
                    }
                }
                else
                {
                    window.location.replace("http://localhost:8080/");
                }
            });
        });
    </script>
</head>

<body style="background-color: gainsboro">
<div class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0" >
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".sidebar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Load balancer</a>
        </div>
    </div>
</div>

<div class="col-lg-4 col-lg-offset-2">
    <div class="panel panel-primary" style="margin: 20px">
        <div class="panel-heading">
            Server 1
        </div>
        <div class="panel-body">
            <p id="usersCount"></p>
            <p id="serverState"></p>
        </div>
        <div class="panel-footer">
        </div>
    </div>
</div>
<div class="col-lg-4">
    <div class="panel panel-primary" style="margin: 20px">
        <div class="panel-heading">
            Server 2
        </div>
        <div class="panel-body">
            <p id="usersCount1"></p>
            <p id="serverState1"></p>
        </div>
        <div class="panel-footer">
        </div>
    </div>
</div>

<button id="connect" type="button" style="height: 150px !important; width: 700px !important; margin-top:120px"
        class="btn btn-primary btn-lg col-lg-offset-3"><h1>CONNECT</h1></button>

</body>
</html>
