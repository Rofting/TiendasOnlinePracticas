
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header-login.jsp"%>
<head>
    <link href="style.css" rel="stylesheet"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Teachers:ital,wght@0,400..800;1,400..800&display=swap" rel="stylesheet">
</head>
 <div class="py-5 container">
     <div class="d-grid gap-2 d-md-flex justify-content-md-end">
         <a href="register-user.jsp" class="btn btn-outline-danger me-md-2" type="button">Check In</a>
     </div>
 </div>

<div class="d-flex align-items-center py-4 bg-body-tertiary bg-image2">


    <main class="form-signin w-100 m-auto ">
        <div class="container">
            <form>
                <h2 class="h3 mb-3 fw-normal text-danger">Log In</h2>
                <div class="form-floating">
                    <input type="text" name="username" class="form-control" id="floatingInput" placeholder="User">
                    <label for="floatingInput">User</label>
                </div>
                <div class="form-floating">
                    <input type="password" name="password" class="form-control" id="floatingPassword" placeholder="password">
                    <label for="floatingPassword">Password</label>
                </div>

                <button class="btn btn-danger w-100 py-2" type="submit">Log In</button>
                <p class="mt-5 mb-3 text-body-secondary">  </p>
            </form>
        </div>
        <br/>
        <div id="result"></div>
    </main>
</div>
<footer class="text-body-secondary py-5">
    <div class="container">
        <p class="mb-1">&copy; 2024 Vintage Bytes Emporium</p>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>

</body>
</html>
