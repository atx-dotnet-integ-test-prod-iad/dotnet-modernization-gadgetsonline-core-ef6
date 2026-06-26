using System.Data.Entity;

namespace GadgetsOnline.Models
{
    /// <summary>
    /// PostgreSQL-compatible database initializer.
    /// 
    /// CreateDatabaseIfNotExists was replaced with NullDatabaseInitializer because:
    ///   1. The target PostgreSQL database and schema (gadgetsonline_dbo) are
    ///      provisioned externally via migration scripts.
    ///   2. EF6 + Npgsql does not support automatic DDL creation the same way
    ///      SQL Server does; letting EF6 attempt to create the database causes
    ///      errors against a pre-existing PostgreSQL instance.
    ///   3. Seed data is managed by the database migration pipeline.
    /// 
    /// To re-enable seeding during development, swap NullDatabaseInitializer for
    /// a custom IDatabaseInitializer<GadgetsOnlineEntities> implementation and
    /// call Database.SetInitializer() from Application_Start.
    /// </summary>
    public class GadgetsOnlineInitializer : NullDatabaseInitializer<GadgetsOnlineEntities>
    {
    }
}
