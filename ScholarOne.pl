#!/usr/bin/perl

# 4-17-2014 version 1
# written by steve spencer
# outomation of scholar one rss feed download and
# upload into cq5
# version 2 add timestamping and header for level1 files
# version 3 archival and directory building
#################
#
#
#################
# modules
use warnings;
use File::Find;
use Getopt::Std;
use File::Basename;
use File::Path;
use File::Copy;
require LWP::UserAgent;
use HTTP::Headers;
use List::Util;
use LWP 5.64;
use LWP::Simple;
use XML::Simple;
use Data::Dumper;
### use DateTime;
# variables
my $xml = new XML::Simple (KeyAttr=>[]);
# my $base = "https://download.abstractcentral.com/acsnationalmock/db35886b690da5cc1de0be665cc4fcc1/";
my $base = "https://download.beta.abstractcentral.com/acsnationalmock/db35886b690da5cc1de0be665cc4fcc1/";
my $xmlPage = "/tmp/divisions.rss";
###### my $dt   = DateTime->now;   # Stores current date and time as datetime object #R2
#  my $ModifiedDate = $dt->ymd;   # Retrieves date as a string in 'yyyy-mm-dd' format R2
my $ModifiedDate = "time2";   # Retrieves date as a string in 'yyyy-mm-dd' format R2
my $ModifiedTime = "time1";   # Retrieves time as a string in 'hh:mm:ss' format R2	
my $cqBASE = '/appl/cq/Scholar/jcr_root/content/user-sandbox/wso/program-list/';
my $level1 = $cqBASE . '.content.xml';
my $baseURL = '/content/user-sandbox/wso/program-list/';
my $urlEXT = '.html';
$j = 0;
##### subs
sub Header1 {
open LEVEL1, ">$level1" || warn " could not open level1 file for writing ";
print LEVEL1 '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
print LEVEL1 '<jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:mix="http://www.jcp.org/jcr/mix/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"' . "\n";
print LEVEL1 ' 	jcr:primaryType="cq:Page"> ' . "\n";
print LEVEL1 '    <jcr:content' . "\n";
print LEVEL1 '       cq:lastModified="{Date}2014-04-17T14:08:00.194-04:00"' . "\n";
print LEVEL1 '       cq:lastModifiedBy="lst99"' . "\n";
print LEVEL1 '        cq:template="/apps/acs/templates/acsArticle"' . "\n";
print LEVEL1 '       jcr:isCheckedOut="{Boolean}true"' . "\n";
print LEVEL1 '       jcr:mixinTypes="[mix:versionable]"' . "\n";
print LEVEL1 '       jcr:primaryType="cq:PageContent"' . "\n";
print LEVEL1 '       jcr:title="PACS Program List"' . "\n";
print LEVEL1 '        jcr:uuid="e54d905a-e447-4e64-82f1-79a321aafd92"' . "\n";
print LEVEL1 '        sling:resourceType="acs/components/pages/acsArticle"' . "\n";
print LEVEL1 '        hideInNav="{Boolean}true">' . "\n";
print LEVEL1 '        <articleContent' . "\n";
print LEVEL1 '            jcr:primaryType="nt:unstructured"' . "\n";
print LEVEL1 '            sling:resourceType="foundation/components/parsys">' . "\n";
print LEVEL1 '	            <table' . "\n";
print LEVEL1 '   		jcr:created="{Date}2014-04-17T14:08:00.194-04:00"' . "\n";
print LEVEL1 '			jcr:createdBy="dyp96"' . "\n";
print LEVEL1 ' 			cq:lastModified="{Date}2014-04-17T14:08:00.194-04:00"' . "\n";		
print LEVEL1 ' 			jcr:lastModifiedBy="lst99"' . "\n";
print LEVEL1 ' 			jcr:primaryType="nt:unstructured"' . "\n";
print LEVEL1 '			sling:resourceType="acs/components/general/table"' ."\n";

}

sub Footer1 {
print LEVEL1 '   </articleContent>' . "\n";
print LEVEL1 ' <articleTitle' . "\n";
print LEVEL1 '	jcr:lastModified="{Date}2014-04-17T13:51:33.591-04:00"' . "\n";
print LEVEL1 ' 	jcr:lastModifiedBy="lst99"' . "\n";
print LEVEL1 '	jcr:primaryType="nt:unstructured"' . "\n";
print LEVEL1 '	jcr:title="Division Abstracts for Meeting [1234]"' . "\n";
print LEVEL1 '	sling:resourceType="acs/components/general/title"/>' . "\n";
print LEVEL1 '	  </jcr:content>' . "\n";
	foreach(@Directories1) {
		print LEVEL1 '		<' . $_ . '>' . "\n";
			}
print LEVEL1 '		</jcr:root>'. "\n";
}

sub Header2 {
open LEVEL2, ">$level2" || warn " could not open level2 file for writing ";
print LEVEL2 '<?xml version="1.0" encoding="UTF-8"?>' . "\n";
print LEVEL2 '<jcr:root xmlns:sling="http://sling.apache.org/jcr/sling/1.0" xmlns:cq="http://www.day.com/jcr/cq/1.0" xmlns:jcr="http://www.jcp.org/jcr/1.0" xmlns:mix="http://www.jcp.org/jcr/mix/1.0" xmlns:nt="http://www.jcp.org/jcr/nt/1.0"' . "\n";
print LEVEL2 ' 	jcr:primaryType="cq:Page"> ' . "\n";
print LEVEL2 '    <jcr:content' . "\n";
print LEVEL2 '       cq:lastModified="{Date}2014-04-17T14:08:00.194-04:00"' . "\n";
print LEVEL2 '        jcr:created="{Date}2014-04-17T11:06:08.475-04:00"' . "\n";
print LEVEL2 '       cq:lastModifiedBy="lst99"' . "\n";
print LEVEL2 '       jcr:createdBy="lst99"' . "\n";
print LEVEL2 '        cq:template="/apps/acs/templates/acsArticle"' . "\n";
print LEVEL2 '       jcr:isCheckedOut="{Boolean}true"' . "\n";
print LEVEL2 '       jcr:mixinTypes="[mix:versionable]"' . "\n";
print LEVEL2 '       jcr:primaryType="nt:unstructured"' . "\n";
print LEVEL2 '       jcr:title="' . $DivisionAcronym . ' Symposia"' . "\n";
print LEVEL2 '        jcr:uuid="e54d905a-e447-4e64-82f1-79a321aafd92"' . "\n";
print LEVEL2 '        sling:resourceType="acs/components/pages/acsArticle"' . "\n";
print LEVEL2 '	       articleLayout="2"' . "\n";
print LEVEL2 '		collapseFooter="o0"'  . "\n";
print LEVEL2 '        hideInNav="true">' . "\n";
print LEVEL2 '		<image'		. "\n";
print LEVEL2 '		jcr:lastModified="{Date}2014-04-17T14:01:51.058-04:00"'  . "\n";
print LEVEL2 '		jcr:lastModifiedBy="lst99"'  . "\n";
print LEVEL2 '		jcr:primaryType="nt:unstructured"' . "\n";
print LEVEL2 '		imageRotate="0"/>' . "\n";
print LEVEL2 '        <articleContent' . "\n";
print LEVEL2 '            jcr:primaryType="nt:unstructured"' . "\n";
print LEVEL2 '            sling:resourceType="foundation/components/parsys">' . "\n";
print LEVEL2 '	            <table' . "\n";
print LEVEL2 '   		jcr:created="{Date}2014-04-17T14:08:00.194-04:00"' . "\n";
print LEVEL2 '			jcr:createdBy="dyp96"' . "\n";
print LEVEL2 ' 			cq:lastModified="{Date}2014-04-17T14:08:00.194-04:00"' . "\n";		
print LEVEL2 ' 			jcr:lastModifiedBy="lst99"' . "\n";
print LEVEL2 ' 			jcr:primaryType="nt:unstructured"' . "\n";
print LEVEL2 '			sling:resourceType="acs/components/general/table"' ."\n";

}

sub Footer2 {
print LEVEL2 '   </articleContent>' . "\n";
print LEVEL2 '	  </jcr:content>' . "\n";
	foreach(@Directories2) {
		print LEVEL2 '		<' . $_ . '>' . "\n";
			}
print LEVEL2 '		</jcr:root>'. "\n";
close(LEVEL2);
}
#################################
sub getLinks {

$file = '/tmp/' . $links;
$level2 = $cqBASE . $DivURL . '/.content.xml';
`wget --no-check-certificate -nv -q -O $file $base$links`;
&Header2;
my $data = $xml->XMLin("$file");
@Directories2 =();
foreach $e (@{$data->{channel}->{item}})
{
	print " level2 \n";
	print $e->{title}, " title2  \n";
	$DivisionAcronym2 = $e->{title};
	$DivURL2 = lc($DivisionAcronym2);
	$DivURL2 =~ s/\s/-/ig;
	push(@Directories2,$DivURL2);
	$cqDIR2 = $cqBASE . $DivURL . '/' . $DivURL2;

	mkpath("$cqDIR2");
	print " path    $cqDIR2 \n";
	print $e->{link}, " link2 \n";
	$links2 =  $e->{link};
	print $e->{description}, " descrption2 \n";
	$Description2 = $e->{description};
	print $e->{pubDate}, "\n";
	$PubDate2 = $e->{pubDate};
	print "\n";
		if ($j == "0") {
			$stringL1 = '&lt;tr>&lt;td>&lt;a href=&quot;' . $baseURL . $DivURL . '/' . $DivURL2 . $urlEXT .'&quot; adhocenable=&quot;false&quot;>' . $DivisionAcronym2 .  '&lt;/a>&lt;/td>&#xa;&lt;td>' . $Description2 . '&lt;/td>&#xa;&lt;td>' . $PubDate2 . '&lt;/td>&#xa;&lt;/tr>';
		}  else {
			$stringL2 =   '&lt;tr>&lt;td>&lt;a href=&quot;' . $baseURL . $DivURL  . '/' . $DivURL2 . $urlEXT .'&quot; adhocenable=&quot;false&quot;>' . $DivisionAcronym2 . '&lt;/a>&lt;/td>&#xa;&lt;td>' . $Description2 . '&lt;/td>&#xa;&lt;td>' . $PubDate2 . '&lt;/td>&#xa;&lt;/tr>';
			$stringL1 =  $stringL1 . $stringL2;
			}
	$j = $j +1;
&getPages;
}
	print LEVEL2 'tableData="&lt;table width=&quot;100%&quot; class=&quot;responsive table table-striped table-bordered&quot;>&#xa;&lt;tbody>&lt;tr>&lt;th>Name&lt;/th>&#xa;&lt;th>Typem&lt;/th>&#xa;&lt;th>Last Updated&lt;/th>&#xa;&lt;/tr>' . "$stringL1" . '&lt;/tbody>&lt;/table>&#xa;"/>' .  "\n";
&Footer2;
 $stringL1 = '';
}
#################################
sub getPages {

	$file = '/tmp/' . $links2;
	`wget -nv -q --no-check-certificate -O $file $base$links2`;
my $data = $xml->XMLin("$file");
foreach $e (@{$data->{channel}->{item}})
{
	# print $e->{title}, "\n";
	# print $e->{link}, "\n";
	$links =  $e->{link};
	# print $e->{description}, "\n";
	# print $e->{pubDate}, "\n";
	print "\n";
} 
} ###### end sub
&Header1;
`wget -nv -q --no-check-certificate -O /tmp/divisions.rss https://download.beta.abstractcentral.com/acsnationalmock/db35886b690da5cc1de0be665cc4fcc1/divisions.rss`;
my $data = $xml->XMLin("$xmlPage");
my $i = 0;
foreach $e (@{$data->{channel}->{item}})
{
	print $e->{title}, " level 1 title \n";
	$DivisionAcronym = $e->{title};
	$DivURL = lc($DivisionAcronym);
	$DivURL = $DivURL . '-symposia';
	push(@Directories1,$DivURL);
	$cqDIR = $cqBASE . $DivURL;
	mkpath("$cqDIR");
	####print $e->{link}, "\n";
	$links =  $e->{link};
	####print $e->{description}, "\n";
	$Description1 = $e->{description};
	##### print $e->{pubDate}, "\n";
	$PubDate1 = $e->{pubDate};
	#### print "\n";
		if ($i == "0") {
			$string = '&lt;tr>&lt;td>&lt;a href=&quot;' . $baseURL . $DivURL . $urlEXT .'&quot; adhocenable=&quot;false&quot;>' . $Description1 . '&lt;/a>&lt;/td>&#xa;&lt;td>' . $DivisionAcronym . '&lt;/td>&#xa;&lt;td>' . $PubDate1 . '&lt;/td>&#xa;&lt;/tr>';
		}  else {
			$string2 =   '&lt;tr>&lt;td>&lt;a href=&quot;' . $baseURL . $DivURL . $urlEXT .'&quot; adhocenable=&quot;false&quot;>' . $Description1 . '&lt;/a>&lt;/td>&#xa;&lt;td>' . $DivisionAcronym . '&lt;/td>&#xa;&lt;td>' . $PubDate1 . '&lt;/td>&#xa;&lt;/tr>';
			$string = $string . $string2;
			}
	$i = $i +1;
	&getLinks;
}  # end of for loop

	print LEVEL1 'tableData="&lt;table width=&quot;100%&quot; class=&quot;responsive table table-striped table-bordered&quot;>&#xa;&lt;tbody>&lt;tr>&lt;th>clDdivision Name&lt;/th>&#xa;&lt;th>Division Acronym&lt;/th>&#xa;&lt;th>Last Updated&lt;/th>&#xa;&lt;/tr>' . "$string" . '&lt;/tbody>&lt;/table>&#xa;"/>' .  "\n";
&Footer1;
# print "$modifiedDate and $modifiedTime \n";
close(LEVEL1);
####### zip the directories 
`zip  -r /appl/cq/Scholar/pacs-1.0.zip /appl/cq/Scholar/META-INF /appl/cq/Scholar/jcr_root`;
`zip  -r pacs-1.0.zip META-INF jcr_root`;
