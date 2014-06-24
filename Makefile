all: 
	@echo "Building..."
	cabal exec ghc -- --make -threaded -rtsopts -with-rtsopts=-N -O2 driver.hs
	@if [ ! -e 'data' ]; then mkdir data; for i in  {1..3000}; do cp template.txt data/$$i.xml ; done; fi
	@echo "Done"



clean:
	rm -rf *.hi *.o *.exe driver data
