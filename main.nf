nextflow.enable.dsl = 2

//params.input = "test_data/*unmapped_{1,2}.fastq.gz"

//raw_reads = params.input
workflow {

    samples = Channel.fromFilePairs("test_data/*unmapped_{1,2}.fastq.gz")
    samples.view()
    contigs = MEGAHIT(samples)
    MULTIQC(contigs.contigs)
}

process MEGAHIT {
    tag "running Megahit on ${sample_id}"
    input:
    tuple val(sample_id), path(reads)

    output:
    path "${sample_id}_contigs/", emit: contigs
    path "${sample_id}.contigs.fastg", emit: fastg


    script:
    """
    megahit -1 ${reads[0]} -2 ${reads[1]} -o ${sample_id}_contigs -m 0.4 --presets meta-large 

    megahit_toolkit contigs2fastg -i ${sample_id}_contigs/final.contigs.fa -o ${sample_id}.contigs.fastg
    """
}

process MULTIQC{
    tag "running MultiQC"
    
    input:
    path contigs

    output:
    path "NextMegaHit_report.HTML", emit: report

    script:
    """
    multiqc ${projectDir} --filename NextMegaHit_report.HTML -f
    """
}

