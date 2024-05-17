
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
    <style>

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }


        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }


        .bd-mode-toggle .dropdown-menu .active .bi {
            display: block !important;
        }
        body {
            height: 100%;
        }


            .form-signin {
            max-width: 330px;
            padding: 1rem;
        }

        .form-signin .form-floating:focus-within {
            z-index: 2;
        }

        .form-signin input[type="email"] {
            margin-bottom: -1px;
            border-bottom-right-radius: 0;
            border-bottom-left-radius: 0;
        }

        .form-signin input[type="password"] {
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }
        .bg-image {
            background-image: url("https://cdn.pixabay.com/photo/2014/09/05/18/32/old-books-436498_1280.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
        }
        .bg-image2 {
            background-image: url("https://wallpaperaccess.com/full/5599491.jpg");
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
        }
    </style>
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
                    <h4>Sobre Nosostros</h4>
                    <p class="text-body-secondary">Somos unos alumnos de 1 de DAM, para conocernos mas contacta con nosotros</p>
                </div>
                <div class="col-sm-4 offset-md-1 py-4">
                    <h4>Contacto</h4>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Siguenos en X</a></li>
                        <li><a href="#" class="text-white">también en Facebook</a></li>
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
                <h2><strong>&nbsp;Practicas</strong></h2>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarHeader" aria-controls="navbarHeader" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
    </div>
</header>

