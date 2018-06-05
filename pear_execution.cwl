#!/home/bfosso/miniconda2/bin/cwl-runner
cwlVersion: v1.0


class: CommandLineTool
label: "PEAR execution"
baseCommand: pear-0.9.6-bin-64

hints:
  SoftwareRequirement:
    packages:
      fastqc:
        specs: [ "https://www.bioinformatics.babraham.ac.uk/projects/fastqc/" ]
        version: [ "v0.9.6" ]

inputs:
  threads:
    type: int
    inputBinding:
      position: 1
      prefix: -j
  max_assembly_length:
    type: ["null", int]
    inputBinding:
      position: 2
      prefix: -m
      separate: true
  min_assembly_length:
    type: ["null", int]
    inputBinding:
      position: 3
      prefix: -n
      separate: true
  quality:
    type: int
    inputBinding:
      separate: true
      position: 4
      prefix: -q
  output_prefix:
    type: string
    inputBinding:
      position: 5
      separate: true
      prefix: -o
  forward:
    type: string
    inputBinding:
      position: 6
      separate: true
      prefix: -f
  reverse:
    type: string
    inputBinding:
      position: 7
      separate: true
      prefix: -r

outputs:
  # output:
  #     type:
  #       type: array
  #       items: File
  #     outputBinding:
  #       # glob: "*.fastq"
  #       glob: $(inputs.output_prefix)*
  merged:
    type: File
    outputBinding:
      glob: $(inputs.output_prefix).assembled.fastq
