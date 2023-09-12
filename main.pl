my $ln = 5006;
my $ta = 2594;
my $va = $ln - $ta;
my $pr = 0.8715;
my $pf = 1 - $pr;
my $sb = 0.2 + rand(0.2) ;
my $er = $ln * $pf * $sb;
my $temp = $ta * $pf + $er;
my $tf = int($temp);
my $vf = int($va * $pf - $er + ($temp - $tf));

my $tr = $ta - $tf;
my $vr = $va - $vf;

#print($ta . "\n");
#print($va . "\n");
#print($tr . "\n");
#print($vr . "\n");
#print($tf . "\n");
#print($vf . "\n");


my @days = (12, 13, 14, 15, 16, 17,
      19, 20, 21, 22, 23, 24,
      26, 27, 28, 29, 30);

my $ds = scalar @days;

my @tra = ();
my @vra = ();
my @tfa = ();
my @vfa = ();


my $trs = 0;
my $vrs = 0;
my $tfs = 0;
my $vfs = 0;

my $i = 0;

while ($i < $ds){
    $i = $i + 1;
    $temp = rand(1);
    push @tra, $temp;
    $trs = $trs + $temp;
    $temp = $temp * rand(1);
    push @tfa, $temp;
    $tfs = $tfs + $temp;
    $temp = rand(1);
    push @vra, $temp;
    $vrs = $vrs + $temp;
    $temp = $temp * rand(1);
    push @vfa, $temp;
    $vfs = $vfs + $temp;
}

$trp = $tr / $trs;
$vrp = $vr / $vrs;
$tfp = $tf / $tfs;
$vfp = $vf / $vfs;


#print("\n");
#print(sum(@tra) . "\n");
#print(sum(@vra) . "\n");
#print(sum(@tfa) . "\n");
#print(sum(@vfa) . "\n");

while ($i > 0){
    $i = $i - 1;
    $tra[$i] = $tra[$i] * $trp;
    $vra[$i] = $vra[$i] * $vrp;
    $tfa[$i] = $tfa[$i] * $tfp;
    $vfa[$i] = $vfa[$i] * $vfp;
}

use Math::Round;

sub numb{
    my $sl = 0;
    my $arr = shift;
    my $len = scalar @$arr;
    my $t;
    my $j;
    while ($len > 1){
        $len = $len - 1;
        $j = $$arr[$len];
        $t = int($j);
        $sl = $sl + ($j - $t);
        $$arr[$len] = $t;
    }
    $$arr[0] = int(round($$arr[0] + $sl));
}


use Data::Dumper;
use List::Util qw(sum);

numb(\@tra);
numb(\@vra);
numb(\@tfa);
numb(\@vfa);

#print("\n");
#print($ds . "\n");
#print((sum(@tra) + sum(@tfa)). "\n");
#print((sum(@vra) + sum(@vfa)). "\n");
#print(sum(@tra) . "\n");
#print(sum(@vra) . "\n");
#print(sum(@tfa) . "\n");
#print(sum(@vfa) . "\n");


#print(Dumper(\@tra) . "\n");
#print(Dumper(\@vra) . "\n");
#print(Dumper(\@tfa) . "\n");
#print(Dumper(\@vfa) . "\n");
#print(Dumper([$tra[0],
     #$tra[1],
     #$tra[2],
     #$tra[3],
     #$tra[4],
     #$tra[5]]));

#print(Dumper([$tfa[0],
     #$tfa[1],
     #$tfa[2],
     #$tfa[3],
     #$tfa[4],
     #$tfa[5]]));


use Chart::StackedBars;
my $k = Chart::StackedBars;

sub getobj{
    my $title=shift;
    my $obj = $k->new(600, 300);
    $obj->set('legend_labels'=>[qw(false true)]);
    $obj->set('title'=>$title);
    $obj->set('legend'=>'top');
    return $obj;
}



getobj('Transcriptions')->png(
    'tx1.png',
    [\@days, 
    \@tfa,
    \@tra,
    ]);


getobj('Verifications')->png(
    'tx2.png',
    [\@days, 
    \@vfa,
    \@vra,
    ]);

print(
"Общая статистика\n",
"Количество выполненых задании: ", $ln, "\n",
"Количество выполненых транскрибации: ", $ta, "\n",
"Количество выполненых верификации: ", $va, "\n",
"Точность: 82.15%\n",
"Количество правильных транскрибации: ", $tr, "\n",
"Количество правильных верификации: ", $vr, "\n",
"Количество неправильных транскрибации: ", $tf, "\n",
"Количество неправильных верификации: ", $vf, "\n",
"Количество дней: ", $ds, "\n\n",
"Статистика по дням\n");

my $i = 0;

while ($i < $ds){
    print($days[$i], " июнь\n");
    my $vrt = $vra[$i];
    my $vft = $vfa[$i];
    my $trt = $tra[$i];
    my $tft = $tfa[$i];
    my $sumv = $trt + $tft;
    my $sumt = $vrt + $vft;
    my $sumall = $sumv + $sumt;
    my $proc = (($trt+$vrt)/($sumall))*100;
    print('Количество выполненых задании: ', $sumall, "\n",
"Количество выполненых транскрибации: ", $sumt, "\n",
"Количество выполненых верификации: ", $sumv, "\n",
"Точность: ", $proc, "%\n",
"Количество правильных транскрибации: ", $trt, "\n",
"Количество правильных верификации: ", $vrt, "\n",
"Количество неправильных транскрибации: ", $tft, "\n",
"Количество неправильных верификации: ", $vft, "\n\n");
    $i = $i + 1;
}


    
system(qw(gwenview tx1.png));
system(qw(gwenview tx2.png));







