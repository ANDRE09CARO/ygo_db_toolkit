#!/bin/bash
echo "                 +--------------------------+"
echo "                 | Welcome to the Yu-Gi-Oh! |"
echo "                 |   cards DB downloader    |"
echo "                 +--------------------------+"
echo ""
echo "> This simple script batch-downloads all the card informations"
echo "  available at www.db.yugioh-card.com !"
echo "> This script will follow 3 steps to get those images :"
echo "  - Downloading the pages showing the card informations"
echo "  - Delete empty files (if the empty_ids_pregen list is... empty)"
echo "  - Extracting the card informations from the html pages"
echo "> To perform a manual download, you have to launch,"
echo "  in order, ygodb.sh rmerr.sh extstr.sh"
echo ""
read -p ">> Do you want to launch an automatic download ? (y/n) :" yn
case $yn in
   [Yy]* ) echo ">> Let's go !";
           sh ./ygodb.sh;
			if [ $(grep -ic [0-9] ./empty_ids_pregen) -ge 1 ]
			then
				read -p ">> Force files verification (if unsure select \"n\") ? (y/n) :" yn2;
				case $yn2 in
				   [Yy]* ) sh ./rmerr.sh;;
				esac
			else
				sh ./rmerr.sh
			fi
           sh ./extstr.sh;
           echo ">> All your cards are belong to us";;
   * ) echo ">> See you !";;
esac
