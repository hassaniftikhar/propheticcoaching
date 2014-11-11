<?php


$id = $argv[1];
$name = $argv[2];
$data = array(
       'id' => $id,
       'name' => $name,
       'avatar' => 'http://mydomain.com/avatar/1.png',
       'expiration' => round(microtime(true) * 1000) + 60*60*1000 // in millisecond
      );


$data = json_encode($data);

$blocksize = 16;
$secret = 'pGJw3J0IcOjtsNeMs4ATNMulpscgpKDf6PWoIUgxdcE5pJ4chdE8pdLrDNMyNsWg';
$md5 = md5($secret);
$key = substr($md5, 0, 16);
$iv = substr($md5, 16, 16);

$size = strlen($data);
$length = ($size % $blocksize);
$pad = $blocksize - $length;
$padc = chr($pad);

$data = $data . str_repeat($padc, $pad);
$encrypted=mcrypt_encrypt(MCRYPT_RIJNDAEL_128, $key, $data, MCRYPT_MODE_CBC, $iv);
$encryptedSession = bin2hex($encrypted);

print $encryptedSession;

?>




