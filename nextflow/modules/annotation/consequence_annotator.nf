process CONSEQUENCE_ANNOTATOR {
    tag "$meta_id.id"
    label 'process_medium'
    container 'ensemblorg/ensembl-vep:release_110'

    input:
    tuple val(meta_id), path(vcf), path(tbi)

    output:
    tuple val(meta_id), path("*.vep.json"), emit: annotated

    script:
    """
    vep \
        --input_file ${vcf} \
        --output_file ${meta_id.id}.vep.json \
        --format vcf \
        --json \
        --cache \
        --offline \
        --everything \
        --canonical \
        --fork ${task.cpus}
    """

    stub:
    """
    touch ${meta_id.id}.vep.json
    """

}
