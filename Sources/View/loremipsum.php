<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href=<?php echo $src_links["bootstrap"] ?> />
		<link rel="stylesheet" href=<?php echo $src_links["css"] ?> />
		<title>BuzzRage - Lorem Ipsum</title>
	</head>
	
	<body class="container-fluid">
		<header class="row">
			<div class="col-lg-12">
				<?php include_once("header.php"); ?>
				<h1>Lorem Ipsum</h1>
			</div>
		</header>
			
		<section class="row">
			<div class="col-lg-offset-3 col-lg-6"><?php echo $lorem_ipsum ?></div>
		</section>
		
		<footer class="row">
			<?php include_once("footer.php"); ?>
		</footer>
	</body>
</html>