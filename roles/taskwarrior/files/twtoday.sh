#!/bin/bash
task due:today -today mod +today
task +today -due:today mod -today
task due:tomorrow -tomorrow mod +tomorrow
task +tomorrow -due:tomorrow mod -tomorrow