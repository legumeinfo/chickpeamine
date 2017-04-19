# chickpeamine
A mine containing *Cicer Arietinum* chickpea (desi) and chickpea (kabuli) genomes.

The data model for this mine contains one important tweak: the addition of ```Organism.variety```, to support two genomes which have the
same taxonId. This also means that a number of updates were done to the processors under the legfed/legfed-chado data source as
well as some core code:

* ```bio/core/main/src/org/intermine/bio/dataconversion/BioDBConverter.java```
* ```bio/core/main/src/org/intermine/bio/util/OrganismData.java```
* ```bio/core/main/src/org/intermine/bio/util/OrganismRepository.java```

The key tweak to chado.organism was to use arietinum_desi and arietinum_kabuli as the species, with the underscore detected by
the source and the text after the underscore put into the variety attribute.

The entrez-organism source does NOT work against this model, and integrate/organism.sql was used to manually update the organism
records, using the trick trigger routine written by Joe Carlson to update the object store.
