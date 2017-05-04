--
-- manually update organisms
--

UPDATE organism SET
genus='Cicer', species='arietinum',
shortname='C. arietinum (kabuli)', name='Cicer arietinum (kabuli)', commonname='chickpea (kabuli)', 
comment='The chickpea (<i>Cicer arietinum</i>) is a legume species in the group of "cool-season" legumes, along with lentil, pea, faba bean and clovers.  Chickpea is one of the earliest cultivated legumes: 7,500-year-old remains have been found in the Middle East.  Other common names for the species include garbanzo bean, ceci bean, sanagalu, chana and Bengal gram. There are two main types of cultivated chickpeas based on seed morphology: desi and kabuli. The kabuli type of chickpea are lighter in color, have a smooth seed coat and about 8 to 9 mm in size. The kabuli type of chickpeas are the most common type found in America. Genome version available on LIS is version CDC Frontier v1.0.'
WHERE variety='kabuli';

UPDATE organism SET 
genus='Cicer', species='arietinum',
shortname='C. arietinum (desi)', name='Cicer arietinum (desi)', commonname='chickpea (desi)', 
comment='The chickpea (<i>Cicer arietinum</i>) is a legume species in the group of "cool-season" legumes, along with lentil, pea, faba bean and clovers.  Chickpea is one of the earliest cultivated legumes: 7,500-year-old remains have been found in the Middle East.  Other common names for the species include garbanzo bean, ceci bean, sanagalu, chana and Bengal gram. There are two main types of cultivated chickpeas based on seed morphology: desi and kabuli. The desi type of chickpea consists of seeds with a yellow interior but have a thick, wrinkled and dark seed coat, the seeds are approximately 6 to 7 mm in size. The majority of desi chickpeas are split in half to make Chana Dahl. ICC 4958, desi type chickpea; genome version available on LIS is version ICC 4958 v2.0.'
WHERE variety='desi';


UPDATE organism SET genus='Phaseolus', species='vulgaris', name='Phaseolus vulgaris', commonname='string bean', shortname='P. vulgaris' WHERE taxonid=3885;
UPDATE organism SET genus='Glycine', species='max', name='Glycine max', commonname='soybean', shortname='G. max' WHERE taxonid=3847;
UPDATE organism SET genus='Arachis', species='duranensis', name='Arachis duranensis', commonname='peanut', shortname='A. duranensis' WHERE taxonid=130453;
UPDATE organism SET genus='Arachis', species='ipaensis', name='Arachis ipaensis', commonname='peanut', shortname='A. ipaensis' WHERE taxonid=130454;
UPDATE organism SET genus='Medicago', species='truncatula', name='Medicago truncatula', commonname='barrel medic', shortname='M. truncatula' WHERE taxonid=3880;
UPDATE organism SET genus='Arabidopsis', species='thaliana', name='Arabidopsis thaliana', commonname='thale cress', shortname='A. thaliana' WHERE taxonid=3702;
