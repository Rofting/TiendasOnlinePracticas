
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>header login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/sign-in/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">
    <link href="style.css" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Teachers:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
</head>

<body class="bg-image">
<script type="text/javascript">
    $(document).ready(function() {
        $("form").on("submit", function(event) {
            event.preventDefault();
            const formValue = $(this).serialize();
            $.ajax("login", {
                type: "POST",
                data: formValue,
                statusCode: {
                    200: function(response) {
                        if (response === "ok") {
                            window.location.href = "/tiendaonlinepracticas";
                        } else {
                            $("#result").html(response);
                        }
                    }
                }
            });
        });
    });
</script>

<header data-bs-theme="dark">
    <div class="collapse text-bg-dark" id="navbarHeader">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-md-7 py-4">
                    <h4>About Us</h4>
                    <p class="text-body-secondary">We are 1St DAM/DAW students, to know more contact us</p>
                </div>
                <div class="col-sm-4 offset-md-1 py-4">
                    <h4>Contacto</h4>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Follow us on X</a></li>
                        <li><a href="#" class="text-white">Also on Facebook</a></li>
                        <li><a href="mailto:practicas@practicas.com" class="text-white">practicas@practicas.com</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="navbar navbar-dark bg-dark shadow-sm">
        <div class="container">
            <a href="/tiendaonlinepracticas" class="navbar-brand d-flex align-items-center">
                <img src="icons/libro.png" height="50" width="50"/>
                <h2><strong>&nbsp;Vintage Bytes Emporium</strong></h2>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </div>
</header>

