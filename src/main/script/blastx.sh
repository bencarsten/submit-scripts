#!/bin/bash

#$ -S /bin/bash

#$ -o /work/$USER/$JOB_NAME-$JOB_ID.log
#$ -j y

[[ $1 = "-h" || $1 = "-help" || $1 = "--help" ]] && {
  echo "usage: <submit-command> [submit-args] $0 query database [blast-arguments]"
  exit 0
}

source @libdir@/submit-scripts/util.sh
source /etc/profile.d/000-modules.sh
module load ncbi-blast
module load pigz

QUERY=$1    ; shift
BLAST_DB=$1 ; shift

OUTPUT=$OUTPUT_DIR/result.gz

read-from $QUERY | ${TRACE:+tracer} blastx -num_threads ${NSLOTS:-1} -db $BLAST_DB "$@" | write-to $OUTPUT
