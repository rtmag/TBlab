bamCoverage -b ENCFF226IAA.bam \
--numberOfProcessors max \
--normalizeTo1x 2451960000 \
-bs 1 \
-o ENCFF226IAA.bw

bamCoverage -b ENCFF632WSK.bam \
--numberOfProcessors max \
--normalizeTo1x 2451960000 \
-bs 1 \
-o ENCFF632WSK.bw

####
# Muscle
more muscle-I20170303-072903-0335-50208034-es.clw |perl -pe 's/\n/HOLA/g'|perl -pe 's/\s+/\t/g'|perl -pe 's/HOLA/\n/g'|cut -f2 > meth.cl
