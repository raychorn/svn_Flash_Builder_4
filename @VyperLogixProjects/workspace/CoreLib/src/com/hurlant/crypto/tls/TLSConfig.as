/**
 * TLSConfig
 * 
 * A set of configuration parameters for use by a TLSSocket or a TLSEngine.
 * Most parameters are optional and will be set to appropriate default values for most use.
 * 
 * Copyright (c) 2007 Henri Torgemane
 * 
 * See LICENSE.txt for full license information.
 */
package com.hurlant.crypto.tls {
	import flash.utils.ByteArray;
	import com.hurlant.util.der.PEM;
	import com.hurlant.crypto.rsa.RSAKey;
	import com.hurlant.crypto.cert.X509CertificateCollection;
	import com.hurlant.crypto.cert.MozillaRootCertificates;
	
	public class TLSConfig {
		public var entity:uint; // SERVER | CLIENT
		
		public var certificate:ByteArray;
		public var privateKey:RSAKey;
		
		public var cipherSuites:Array;
		
		public var compressions:Array;
		
		public var CAStore:X509CertificateCollection;
		
		public function TLSConfig(	entity:uint, cipherSuites:Array = null, compressions:Array = null, 
									certificate:ByteArray = null, privateKey:RSAKey = null, CAStore:X509CertificateCollection = null) {
			this.entity = entity;
			this.cipherSuites = cipherSuites;
			this.compressions = compressions;
			this.certificate = certificate;
			this.privateKey = privateKey;
			this.CAStore = CAStore;
			
			// default settings.
			if (cipherSuites==null) {
				this.cipherSuites = CipherSuites.getDefaultSuites();
			}
			if (compressions==null) {
				this.compressions = [TLSSecurityParameters.COMPRESSION_NULL];
			}
			
			if (CAStore==null) {
				this.CAStore = new MozillaRootCertificates;
			}
		}
		
		public function setPEMCertificate(cert:String, key:String = null):void {
			if (key == null) {
				key = cert; // for folks who like to concat those two in one file.
			}
			certificate = PEM.readCertIntoArray(cert);
			privateKey = PEM.readRSAPrivateKey(key);
		}
	}
}