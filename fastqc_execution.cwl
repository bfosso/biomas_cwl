#!/home/bfosso/miniconda2/bin/cwl-runner
cwlVersion: v1.0

class: CommandLineTool
label: "fastqc execution"
baseCommand: fastqc

hints:
  SoftwareRequirement:
    packages:
      fastqc:
        specs: [ "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/" ]
        version: [ "v0.10.1" ]

#fastqc -t 4 --noextract -q -o fastqc_computation %s %s" % (R1,R2)
inputs:
  threads:
    type: int
    inputBinding:
      position: 1
      prefix: -t
  extraction:
    type: boolean
    inputBinding:
      position: 2
      prefix: --noextract
  fastq:
    type: boolean
    inputBinding:
      position: 3
      prefix: -q
  output_folder:
    type: ["null", string]
    inputBinding:
      separate: true
      position: 4
      prefix: -o
  input_PE_R1_fastq:
    type: string
    inputBinding:
      position: 5
  input_PE_R2_fastq:
    type: string
    inputBinding:
      position: 6


outputs: []
