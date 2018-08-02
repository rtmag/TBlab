java -jar /home/rtm/myprograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true \
METRICS_FILE=/home/rtm/Desktop/myc_dan/NTC.mfile \
INPUT=/home/rtm/Desktop/myc_dan/NTC_H2Az_A004_S1/Aligned.sortedByCoord.out.bam \
OUTPUT=/home/rtm/Desktop/myc_dan/NTC_rmdup.bam &

java -jar /home/rtm/myprograms/picard/build/libs/picard.jar MarkDuplicates REMOVE_DUPLICATES=true \
METRICS_FILE=/home/rtm/Desktop/myc_dan/siMyc.mfile \
INPUT=/home/rtm/Desktop/myc_dan/siMyc_H2Az_A006_S3/Aligned.sortedByCoord.out.bam \
OUTPUT=/home/rtm/Desktop/myc_dan/siMyc_rmdup.bam &


python /home/rtm/myprograms/danpos-2.2.2/danpos.py dpos --paired 1 -o NTC_res NTC &> NTC.log

python /home/rtm/myprograms/danpos-2.2.2/danpos.py dpos --paired 1 -o siMyc_res siMyc &> siMyc.log

python /home/rtm/myprograms/danpos-2.2.2/danpos.py wiq --buffer_size 70 hg38.chrom.sizes_noCHR NTC.smooth.wig:siMyc.smooth.wig &> norm.log
################################################################################################################
more NTC.smooth.qnor.wig | perl -pe 's/chrom\=/chrom\=chr/g' > NTC.smooth.qnor_chr.wig
more siMyc.smooth.qnor.wig | perl -pe 's/chrom\=/chrom\=chr/g' > siMyc.smooth.qnor_chr.wig

~/myprograms/kentUtils/bin/linux.x86_64/wigToBigWig NTC.smooth.qnor_chr.wig /home/rtm/references/hg38.chrom.sizes NTC.smooth.qnor.bw  -clip
~/myprograms/kentUtils/bin/linux.x86_64/wigToBigWig siMyc.smooth.qnor_chr.wig /home/rtm/references/hg38.chrom.sizes siMyc.smooth.qnor.bw  -clip
