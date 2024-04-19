<?php
define('DEBUG', false);
if (DEBUG) {
    if (!is_dir(__DIR__.'/data')){
        if (!mkdir(__DIR__.'/data', 0775)){
            exit('Error!');
        }
    }
    if (!is_dir(__DIR__.'/log')){
        if (!mkdir(__DIR__.'/log', 0775)){
            exit('Error!');
        }
    }
}
ini_set('date.timezone', 'Asia/Tokyo');
ini_set('error_log', __DIR__.'/log/error.log');
ini_set('html_errors', '0');
ini_set('log_errors',  '1');
if (DEBUG) {
    error_reporting(E_ALL);
    ini_set('display_errors', '1');
} else {
    error_reporting(E_ERROR|E_WARNING|E_PARSE);
    ini_set('display_errors', '0');
}
$bizid  = '17841450098015496';
$token  = 'EAAF6lHSYwcYBAOOdZBmcZBz5ObNMR8yzuOsSlSkJZAgrE1mylBaP0Gm4Q4AzIdece'
         .'56w1WVlbIci4agQOXBwJYA5gg3r7xW5z4JZBFZCIodUjzhY1QM2cCRP6BgoQbz9ibk'
         .'q4zlogVi1x51OZA67fSTGtWnZCiNvemEVnoeau4W2H5TeanqUQIsET6qgIx4uRgZD';
$userid = 'view_0813';
if (isset($_GET['id']) && preg_match('/^[\w.]{1,30}$/', $_GET['id'])){
    $userid = $_GET['id'];
}
$now  = new DateTime();
$file = __DIR__.'/data/'.$userid;
if (is_writable($file)){
    $data = unserialize(file_get_contents($file));
    $pre = new DateTime($data['time']);
    $pre->add(new DateInterval('PT1H'));
    if ($now < $pre){
        echo($data['insta']);
    }else{
        feed();
    }
}else{
    feed();
}
function feed(){
    global $userid, $bizid, $token, $now, $file;

    $query = 'business_discovery.username('.$userid.')'
             .'{media{media_type,media_url,permalink,caption}}';
    $url   = 'https://graph.facebook.com/'
             .$bizid.'?fields='.$query.'&access_token='.$token;
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    $res = curl_exec($ch);
    curl_close($ch);
    $date = $now->format('Y-m-d H:i:s');
    $data = ['time' => $date, 'insta' => $res];
    file_put_contents($file, serialize($data));
    echo $res;
}
