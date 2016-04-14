#! /usr/bin/perl
use LWP::Simple;
# Let user choose the theater
print $temp = "請選擇影城 \n 1 台南國賓影城\n 2 台南新光影城\n 3 台南威秀影城\n? ";
$theater = <STDIN>;

# get the right theater's webside http code
if ($theater == "1") {
  $doc = get 'http://www.atmovies.com.tw/showtime/theater_t06608_a06.html';
} elsif($theater == "2") {
  $doc = get 'http://www.atmovies.com.tw/showtime/theater_t06607_a06.html';
} elsif($theater =~ "3") {
  $doc = get 'http://www.atmovies.com.tw/showtime/theater_t06609_a06.html';
}

# split the code with "<"
@lines = split(/</,$doc);

binmode(STDOUT, ":encoding(utf8)");
foreach $line (@lines) {
  # find next movie 
  # if there has unprinted information of movies, print it out
  if ($line =~ /theaterShowtimeTable/) {
  }
  # find the title of movie
  if ($line =~ /a href="\/movie\/.*">(.*)\s*/) {
    if ($MovieName) {
      print "$MovieName\n";
      foreach $t (@time) {
        print $t, "\n";
      }
    }
    $MovieName = $1;
    @time = ();
  }
    # find the version of movie
  elsif ($line =~ /li class="filmVersion">(.*)/) {
    $MovieName = $MovieName." (".$1.")";
  }
  # find movie's showtime
  elsif ($line =~ /li>(\d\d.\d\d)/) {
    push(@time,$1); 
  }
  # find movie's showtime
  elsif ($line =~ /a href="\/showtime\/ticket.*>(\d\d.\d\d)/) {
    push(@time,$1);
  }
}
print "$MovieName\n";
foreach $t (@time) {
  print $t, "\n";
}

