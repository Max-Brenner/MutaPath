include { MUTAPATH } from './workflows/mutapath.nf'

workflow {

    // Samplesheet: CSV with columns [sample_id, vcf, reference, gtf]
    // Optional: bed (region filter)
    Channel
        .fromPath(params.samplesheet)
        .splitCsv(header: true)
        .map { row ->
            def meta = [id: row.sample_id]
            [meta, file(row.vcf), file(row.reference), file(row.gtf)]
        }
        .set { ch_input }

    MUTAPATH(ch_input)

}
