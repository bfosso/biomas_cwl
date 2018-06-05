#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
label: "BioMaS (Bioinformatic analysis of Metagenomic ampliconS)"
inputs:
  R1: string
  R2: string
  prefix: string
  processors: int
  qual: int
  min_ass_len: ["null", int]
  max_ass_len: ["null", int]
  min_len: int
  fastqc_extract: boolean
  fastq_type: boolean
  folder_out: ["null", string]
  paired: boolean
  stringcency: int
  uc_derep: string
  log_derep: string
  quiet_derep: boolean
  merged_fasta: string
  RDP_full_path: Any
  RDP_unclass: Any
  fq_flag: boolean
  seed: int
  n_match: int
  local: boolean
  unaligned: boolean
  no_uncl_PE_sam: string
  uncl_PE_sam: string
  no_uncl_SE_sam: string
  uncl_SE_sam: string
  tango_dmp: string
  visualization_file: string
  q_val_over: float
  q_val_unde: float
  over_tax: string
  under_tax: string
# requirements:
#   - class: EnvVarRequirement
#     envDef:
#       - envName: CodeDir
#         envValue:
#           engine: "cwl:JsonPointer"
#           script: /home/bfosso/Codici_programmi/BioMaS/CWL_codes/

outputs:
  merged_fastq:
    type: File
    outputSource: pear/merged
  R1_un:
    type: File
    outputSource: trim/R1_trimmed
  R2_un:
    type: File
    outputSource: trim/R2_trimmed
  merge_fasta:
    type: File
    outputSource: fastq2fasta/output_fasta
  derer_log_file:
    type: File
    outputSource: dereplication/log_file
  derer_uc_file:
    type: File
    outputSource: dereplication/output_cluster
  dereplicate_fastq_file:
    type: File
    outputSource: create_dereplicate_file/output_fastq
  PE_mapping_no_uncul:
    type: File
    outputSource: unmerged_PE_mapping_no_uncul/output_file_sam
  PE_mapping_uncul:
    type: File
    outputSource: unmerged_PE_mapping_uncul/output_file_sam
  SE_mapping_uncul:
    type: File
    outputSource: merged_SE_mapping_uncul/output_file_sam
  SE_mapping_no_uncl:
    type: File
    outputSource: merged_SE_mapping_no_uncul/output_file_sam
  over_97_match:
    type: File
    outputSource: sam_parsing/over_97
  under_97_match:
    type: File
    outputSource: sam_parsing/under_97
  over_97_ass:
    type: File
    outputSource: assign_over97/assignment
  under_97_ass:
    type: File
    outputSource: assign_unde97/assignment
  # fastqc_out:
  #   type: File
  #   outputSource: fastqc/

steps:
  fastqc:
    run: fastqc_execution.cwl
    in:
      threads: processors
      extraction: fastqc_extract
      fastq: fastq_type
      output_folder: folder_out
      input_PE_R1_fastq: R1
      input_PE_R2_fastq: R2

    out: []

  pear:
    run: pear_execution.cwl
    in:
      threads: processors
      max_assembly_length: max_ass_len
      min_assembly_length: min_ass_len
      quality: qual
      output_prefix: prefix
      forward: R1
      reverse: R2

    out:
      [merged]

  prepare_trimming:
    run: prepare_trimming_data.cwl
    in:
      prefisso: prefix
      forward: R1
      reverse: R2
      merged: pear/merged

    out:
      [R1_unmerged, R2_unmerged]

  trim:
    run: trim_galore_execution.cwl
    in:
      quality: qual
      length: min_len
      stringency: stringcency
      pair: paired
      zip: fastqc_extract
      R1: prepare_trimming/R1_unmerged
      R2: prepare_trimming/R2_unmerged
    out:
      [R1_trimmed, R2_trimmed]

  fastq2fasta:
    run: fastq2fasta.cwl
    in:
      filter_fastq: pear/merged
      fasta: merged_fasta
    out:
      [output_fasta]

  dereplication:
    run: dereplication.cwl
    in:
      derep_full: fastq2fasta/output_fasta
      uc: uc_derep
      log: log_derep
      quiet: quiet_derep
      threads: processors
    out:
      [output_cluster, log_file]

  create_dereplicate_file:
    run: dereplicated_file.cwl
    in:
      fastq_file: pear/merged
      prefix: prefix
      ucfile: dereplication/output_cluster
    out:
      [output_fastq]

  unmerged_PE_mapping_no_uncul:
    run: bowtie2_PE.cwl
    in:
      fastq_flag: fq_flag
      seed_n: seed
      index_loc: RDP_full_path
      match_n: n_match
      input_PE_R1_fastq: trim/R1_trimmed
      input_PE_R2_fastq: trim/R2_trimmed
      output_sam: no_uncl_PE_sam
      processors: processors
      local_alignment: local
      unaligned_items: unaligned
    out:
      [output_file_sam]

  unmerged_PE_mapping_uncul:
    run: bowtie2_PE.cwl
    in:
      fastq_flag: fq_flag
      seed_n: seed
      index_loc: RDP_unclass
      match_n: n_match
      input_PE_R1_fastq: trim/R1_trimmed
      input_PE_R2_fastq: trim/R2_trimmed
      output_sam: uncl_PE_sam
      processors: processors
      local_alignment: local
      unaligned_items: unaligned
    out:
      [output_file_sam]

  merged_SE_mapping_no_uncul:
    run: bowtie2_SE.cwl
    in:
      fastq_flag: fq_flag
      seed_n: seed
      index_loc: RDP_full_path
      match_n: n_match
      input_SE_fastq: create_dereplicate_file/output_fastq
      output_sam: no_uncl_SE_sam
      processors: processors
      local_alignment: local
      unaligned_items: unaligned
    out:
      [output_file_sam]

  merged_SE_mapping_uncul:
    run: bowtie2_SE.cwl
    in:
      fastq_flag: fq_flag
      seed_n: seed
      index_loc: RDP_unclass
      match_n: n_match
      input_SE_fastq: create_dereplicate_file/output_fastq
      output_sam: uncl_SE_sam
      processors: processors
      local_alignment: local
      unaligned_items: unaligned
    out:
      [output_file_sam]

  sam_parsing:
    run: sam_parsing.cwl
    in:
      se_no_uncl: merged_SE_mapping_no_uncul/output_file_sam
      se_uncl: merged_SE_mapping_uncul/output_file_sam
      pe_no_uncl: unmerged_PE_mapping_no_uncul/output_file_sam
      pe_uncl: unmerged_PE_mapping_uncul/output_file_sam
      nodes_file: visualization_file
    out:
      [over_97, under_97]

  assign_over97:
    run: tango_application.cwl
    in:
      ref_taxonomy: tango_dmp
      input_matches: sam_parsing/over_97
      q_val: q_val_over
      outfile: over_tax
    out:
      [assignment]

  assign_unde97:
    run: tango_application.cwl
    in:
      ref_taxonomy: tango_dmp
      input_matches: sam_parsing/under_97
      q_val: q_val_unde
      outfile: under_tax
    out:
      [assignment]
