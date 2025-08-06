nextflow.enable.dsl = 2

//params.input = "test_data/*unmapped_{1,2}.fastq.gz"

//raw_reads = params.input
workflow {

    samples = Channel.fromFilePairs("test_data/*unmapped_{1,2}.fastq.gz")
    samples.view()
    mega = MEGAHIT(samples)
    //multiqc = MULTIQC(mega)
}

process MEGAHIT {
    tag "running Megahit on ${sample_id}"
    input:
    tuple val(sample_id), path(reads)

    //output:

    script:
    """
    echo 'ID = ${sample_id} forward = ${reads[0]} reverse = ${reads[1]}'
    """

}

process MULTIQC{
    tag "running MultiQC on $mega"
    input:
        path mega
    output:
        path "multiqc_report.html"

    script:
    """
    multiqc $mega -o .
    """
}

