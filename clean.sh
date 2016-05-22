#!/bin/bash
echo ">> let's clean all your experiments..."

read -p "> Clean \"empty_ids\" list ? (y/n) :" yn1;
case $yn1 in
   [Yy]* ) rm ./empty_ids;
           touch ./empty_ids;;
esac

read -p "> Clean \"loc\" file ? (y/n) :" yn3;
case $yn3 in
   [Yy]* ) echo "en" > ./loc;;
esac

read -p "> Clean loc \"empty\" folder ? (y/n) :" yn4;
case $yn4 in
   [Yy]* ) rm -r ./empty;
           mkdir ./empty;;
esac

read -p "> Clean loc \"html\" folder ? (y/n) :" yn5;
case $yn5 in
   [Yy]* ) rm -r ./html;
		   mkdir ./html;;
esac

read -p "> Clean loc \"txt\" folder ? (y/n) :" yn6;
case $yn6 in
   [Yy]* ) rm -r ./txt;
		   mkdir ./txt;;
esac
