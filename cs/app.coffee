module.exports =
    run: ->
        config = require 'config'
        {dispatch_impl} = require 'libprotocol'
        qm = require 'queue-manager'
        {info} = dispatch_impl 'ILogger', 'App'
        idom = dispatch_impl 'IDom'

        qm.put_to_queue('document_ready_queue', [
            -> info "**Starting doc rdy queue"
            ->
                dna = require 'dna-lang'
                dna.start_synthesis document.body
            -> info "**doc rdy queue done"
        ])

        idom.on_dom_ready -> qm.run_queue 'document_ready_queue'
